import com.sun.net.httpserver.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class ChambreHandler implements HttpHandler {

    public void handle(HttpExchange ex) throws IOException {
        if (Util.cors(ex)) return;
        try {
            String method = ex.getRequestMethod();
            String path   = ex.getRequestURI().getPath();
            if (method.equals("GET") && path.equals("/api/chambres"))
                rechercher(ex);
            else if (method.equals("GET") && path.equals("/api/hotels"))
                hotels(ex);
            else if (method.equals("POST") && path.equals("/api/chambres"))
                ajouter(ex);
            else if (method.equals("PUT") && path.equals("/api/chambres"))
                modifier(ex);
            else if (method.equals("DELETE") && path.equals("/api/chambres"))
                supprimer(ex);
            else
                Util.json(ex, 404, "{\"erreur\":\"route inconnue\"}");
        } catch (Exception e) {
            e.printStackTrace();
            try { Util.json(ex, 500, "{\"erreur\":\""+Util.esc(e.getMessage())+"\"}"); }
            catch (IOException ignored) {}
        }
    }

    private void rechercher(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.query(ex);
        String dd = p.get("dateDebut"), df = p.get("dateFin");
        String cap = p.get("capacite"), ch = p.get("chaine");
        String cat = p.get("categorie"), pm = p.get("prixMax"), sf = p.get("superficieMin");

        StringBuilder sql = new StringBuilder(
            "SELECT c.chambre_id, c.prix, c.commodites, c.capacite, c.vue," +
            " c.lit_supplementaire, c.etat_dommages, c.superficie," +
            " h.adresse AS hotel, h.hotel_id, h.categorie, ch.nom AS chaine" +
            " FROM CHAMBRE c" +
            " JOIN HOTEL h ON c.hotel_id=h.hotel_id" +
            " JOIN CHAINE ch ON h.chaine_id=ch.chaine_id" +
            " WHERE 1=1");
        List<Object> args = new ArrayList<>();

        if (dd!=null && df!=null && !dd.isEmpty() && !df.isEmpty()) {
            sql.append(" AND c.chambre_id NOT IN" +
                "(SELECT chambre_id FROM RESERVATION WHERE statut NOT IN ('annulee','annulée')" +
                " AND date_debut < ?::date AND date_fin > ?::date)");
            args.add(df); args.add(dd);
            sql.append(" AND c.chambre_id NOT IN" +
                "(SELECT chambre_id FROM LOCATION WHERE date_debut < ?::date AND date_fin > ?::date)");
            args.add(df); args.add(dd);
        }
        if (cap!=null&&!cap.isEmpty())  { sql.append(" AND c.capacite=?");      args.add(cap); }
        if (ch!=null&&!ch.isEmpty())    { sql.append(" AND ch.nom=?");           args.add(ch); }
        if (cat!=null&&!cat.isEmpty())  { sql.append(" AND h.categorie=?");      args.add(Integer.parseInt(cat)); }
        if (pm!=null&&!pm.isEmpty())    { sql.append(" AND c.prix<=?");          args.add(Double.parseDouble(pm)); }
        if (sf!=null&&!sf.isEmpty())    { sql.append(" AND c.superficie>=?");    args.add(Double.parseDouble(sf)); }
        sql.append(" ORDER BY c.prix ASC LIMIT 200");

        PreparedStatement ps = DB.get().prepareStatement(sql.toString());
        for (int i=0;i<args.size();i++) ps.setObject(i+1, args.get(i));
        ResultSet rs = ps.executeQuery();

        StringBuilder j = new StringBuilder("[");
        boolean first=true;
        while (rs.next()) {
            if (!first) j.append(","); first=false;
            j.append("{")
             .append("\"chambreId\":").append(rs.getInt("chambre_id")).append(",")
             .append("\"hotelId\":").append(rs.getInt("hotel_id")).append(",")
             .append("\"hotel\":\"").append(Util.esc(rs.getString("hotel"))).append("\",")
             .append("\"chaine\":\"").append(Util.esc(rs.getString("chaine"))).append("\",")
             .append("\"categorie\":").append(rs.getInt("categorie")).append(",")
             .append("\"capacite\":\"").append(Util.esc(rs.getString("capacite"))).append("\",")
             .append("\"vue\":\"").append(Util.esc(rs.getString("vue"))).append("\",")
             .append("\"prix\":").append(rs.getDouble("prix")).append(",")
             .append("\"superficie\":").append(rs.getDouble("superficie")).append(",")
             .append("\"commodites\":\"").append(Util.esc(rs.getString("commodites"))).append("\",")
             .append("\"litSup\":").append(rs.getBoolean("lit_supplementaire")).append(",")
             .append("\"dommages\":").append(rs.getString("etat_dommages")!=null
                 ? "\""+Util.esc(rs.getString("etat_dommages"))+"\""  : "null")
             .append("}");
        }
        j.append("]");
        Util.json(ex, 200, j.toString());
    }

    private void hotels(HttpExchange ex) throws Exception {
        ResultSet rs = DB.get().prepareStatement(
            "SELECT h.hotel_id, h.adresse, h.categorie, h.nb_chambres, h.email, h.telephone," +
            " ch.nom AS chaine FROM HOTEL h JOIN CHAINE ch ON h.chaine_id=ch.chaine_id" +
            " ORDER BY ch.nom, h.adresse").executeQuery();
        StringBuilder j = new StringBuilder("[");
        boolean first=true;
        while (rs.next()) {
            if (!first) j.append(","); first=false;
            j.append("{")
             .append("\"hotelId\":").append(rs.getInt("hotel_id")).append(",")
             .append("\"adresse\":\"").append(Util.esc(rs.getString("adresse"))).append("\",")
             .append("\"categorie\":").append(rs.getInt("categorie")).append(",")
             .append("\"nbChambres\":").append(rs.getInt("nb_chambres")).append(",")
             .append("\"email\":\"").append(Util.esc(rs.getString("email"))).append("\",")
             .append("\"telephone\":\"").append(Util.esc(rs.getString("telephone"))).append("\",")
             .append("\"chaine\":\"").append(Util.esc(rs.getString("chaine"))).append("\"")
             .append("}");
        }
        j.append("]");
        Util.json(ex, 200, j.toString());
    }

    private void ajouter(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.body(ex);
        PreparedStatement ps = DB.get().prepareStatement(
            "INSERT INTO CHAMBRE(hotel_id,prix,commodites,capacite,vue,lit_supplementaire,etat_dommages,superficie)" +
            " VALUES(?,?,?,?,?,?,?,?) RETURNING chambre_id");
        ps.setInt(1, Integer.parseInt(p.get("hotelId")));
        ps.setDouble(2, Double.parseDouble(p.get("prix")));
        ps.setString(3, p.get("commodites"));
        ps.setString(4, p.get("capacite"));
        ps.setString(5, p.get("vue"));
        ps.setBoolean(6, "true".equals(p.get("litSup")));
        ps.setString(7, p.getOrDefault("dommages", null));
        ps.setDouble(8, Double.parseDouble(p.getOrDefault("superficie","20")));
        ResultSet rs = ps.executeQuery();
        rs.next();
        Util.json(ex, 200, "{\"success\":true,\"chambreId\":"+rs.getInt(1)+"}");
    }

    private void modifier(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.body(ex);
        PreparedStatement ps = DB.get().prepareStatement(
            "UPDATE CHAMBRE SET prix=?,commodites=?,capacite=?,vue=?,lit_supplementaire=?,etat_dommages=?,superficie=?" +
            " WHERE chambre_id=?");
        ps.setDouble(1, Double.parseDouble(p.get("prix")));
        ps.setString(2, p.get("commodites"));
        ps.setString(3, p.get("capacite"));
        ps.setString(4, p.get("vue"));
        ps.setBoolean(5, "true".equals(p.get("litSup")));
        ps.setString(6, p.getOrDefault("dommages",""));
        ps.setDouble(7, Double.parseDouble(p.getOrDefault("superficie","20")));
        ps.setInt(8, Integer.parseInt(p.get("chambreId")));
        ps.executeUpdate();
        Util.json(ex, 200, "{\"success\":true}");
    }

    private void supprimer(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.query(ex);
        PreparedStatement ps = DB.get().prepareStatement("DELETE FROM CHAMBRE WHERE chambre_id=?");
        ps.setInt(1, Integer.parseInt(p.get("chambreId")));
        ps.executeUpdate();
        Util.json(ex, 200, "{\"success\":true}");
    }
}