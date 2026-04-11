import com.sun.net.httpserver.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class ReservationHandler implements HttpHandler {

    public void handle(HttpExchange ex) throws IOException {
        if (Util.cors(ex)) return;
        String method = ex.getRequestMethod();
        String path   = ex.getRequestURI().getPath();
        try {
            if (path.startsWith("/api/reservation")) {
                if      (method.equals("GET"))    listerRes(ex);
                else if (method.equals("POST"))   creerRes(ex);
                else if (method.equals("DELETE")) annulerRes(ex);
                else Util.json(ex, 405, "{\"erreur\":\"methode non supportee\"}");
            } else if (path.startsWith("/api/location")) {
                if      (method.equals("GET"))  listerLoc(ex);
                else if (method.equals("POST")) creerLoc(ex);
                else Util.json(ex, 405, "{\"erreur\":\"methode non supportee\"}");
            } else {
                Util.json(ex, 404, "{\"erreur\":\"route inconnue\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            try { Util.json(ex, 500, "{\"erreur\":\""+Util.esc(e.getMessage())+"\"}"); }
            catch (IOException ignored) {}
        }
    }

    // ── RÉSERVATIONS ──────────────────────────────────────────

    private void listerRes(HttpExchange ex) throws Exception {
        ResultSet rs = DB.get().prepareStatement(
            "SELECT r.reservation_id, r.chambre_id, r.date_reservation, r.date_debut, r.date_fin, r.statut," +
            " c.prix, h.adresse AS hotel, ch.nom AS chaine," +
            " cl.nom_complet AS client_nom, cl.client_id" +
            " FROM RESERVATION r" +
            " JOIN CHAMBRE c ON r.chambre_id=c.chambre_id" +
            " JOIN HOTEL h ON c.hotel_id=h.hotel_id" +
            " JOIN CHAINE ch ON h.chaine_id=ch.chaine_id" +
            " JOIN CLIENT cl ON r.client_id=cl.client_id" +
            " ORDER BY r.date_debut DESC").executeQuery();
        StringBuilder j = new StringBuilder("[");
        boolean first=true;
        while (rs.next()) {
            if (!first) j.append(","); first=false;
            j.append("{")
             .append("\"id\":").append(rs.getInt("reservation_id")).append(",")
             .append("\"chambreId\":").append(rs.getInt("chambre_id")).append(",")
             .append("\"clientId\":").append(rs.getInt("client_id")).append(",")
             .append("\"clientNom\":\"").append(Util.esc(rs.getString("client_nom"))).append("\",")
             .append("\"hotel\":\"").append(Util.esc(rs.getString("hotel"))).append("\",")
             .append("\"chaine\":\"").append(Util.esc(rs.getString("chaine"))).append("\",")
             .append("\"dateDebut\":\"").append(rs.getDate("date_debut")).append("\",")
             .append("\"dateFin\":\"").append(rs.getDate("date_fin")).append("\",")
             .append("\"statut\":\"").append(Util.esc(rs.getString("statut"))).append("\",")
             .append("\"prix\":").append(rs.getDouble("prix"))
             .append("}");
        }
        j.append("]");
        Util.json(ex, 200, j.toString());
    }

    private void creerRes(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.body(ex);
        String nas = p.get("nas");

        // Trouver ou créer client
        PreparedStatement find = DB.get().prepareStatement(
            "SELECT client_id FROM CLIENT WHERE nas=?");
        find.setString(1, nas);
        ResultSet rf = find.executeQuery();
        int clientId;
        if (rf.next()) {
            clientId = rf.getInt(1);
        } else {
            PreparedStatement ins = DB.get().prepareStatement(
                "INSERT INTO CLIENT(nom_complet,adresse,nas) VALUES(?,?,?) RETURNING client_id");
            ins.setString(1, p.getOrDefault("nomComplet","Inconnu"));
            ins.setString(2, p.getOrDefault("adresse",""));
            ins.setString(3, nas);
            ResultSet ri = ins.executeQuery();
            ri.next();
            clientId = ri.getInt(1);
        }

        PreparedStatement ps = DB.get().prepareStatement(
            "INSERT INTO RESERVATION(chambre_id,client_id,date_debut,date_fin,statut)" +
            " VALUES(?,?,?,?,'en attente') RETURNING reservation_id");
        ps.setInt(1, Integer.parseInt(p.get("chambreId")));
        ps.setInt(2, clientId);
        ps.setDate(3, java.sql.Date.valueOf(p.get("dateDebut")));
        ps.setDate(4, java.sql.Date.valueOf(p.get("dateFin")));
        ResultSet rs = ps.executeQuery();
        rs.next();
        Util.json(ex, 200, "{\"success\":true,\"reservationId\":"+rs.getInt(1)+",\"clientId\":"+clientId+"}");
    }

    private void annulerRes(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.query(ex);
        PreparedStatement ps = DB.get().prepareStatement(
            "UPDATE RESERVATION SET statut='annulee' WHERE reservation_id=?");
        ps.setInt(1, Integer.parseInt(p.get("id")));
        ps.executeUpdate();
        Util.json(ex, 200, "{\"success\":true}");
    }

    // ── LOCATIONS ─────────────────────────────────────────────

    private void listerLoc(HttpExchange ex) throws Exception {
        ResultSet rs = DB.get().prepareStatement(
            "SELECT l.location_id, l.chambre_id, l.date_checkin, l.date_debut, l.date_fin," +
            " l.reservation_id, c.prix, h.adresse AS hotel," +
            " cl.nom_complet AS client_nom, e.nom_complet AS employe_nom" +
            " FROM LOCATION l" +
            " JOIN CHAMBRE c ON l.chambre_id=c.chambre_id" +
            " JOIN HOTEL h ON c.hotel_id=h.hotel_id" +
            " JOIN CLIENT cl ON l.client_id=cl.client_id" +
            " JOIN EMPLOYE e ON l.employe_id=e.employe_id" +
            " ORDER BY l.date_checkin DESC").executeQuery();
        StringBuilder j = new StringBuilder("[");
        boolean first=true;
        while (rs.next()) {
            if (!first) j.append(","); first=false;
            j.append("{")
             .append("\"id\":").append(rs.getInt("location_id")).append(",")
             .append("\"chambreId\":").append(rs.getInt("chambre_id")).append(",")
             .append("\"hotel\":\"").append(Util.esc(rs.getString("hotel"))).append("\",")
             .append("\"clientNom\":\"").append(Util.esc(rs.getString("client_nom"))).append("\",")
             .append("\"employeNom\":\"").append(Util.esc(rs.getString("employe_nom"))).append("\",")
             .append("\"dateCheckin\":\"").append(rs.getDate("date_checkin")).append("\",")
             .append("\"dateDebut\":\"").append(rs.getDate("date_debut")).append("\",")
             .append("\"dateFin\":\"").append(rs.getDate("date_fin")).append("\",")
             .append("\"reservationId\":").append(rs.getObject("reservation_id")==null?"null":rs.getInt("reservation_id")).append(",")
             .append("\"prix\":").append(rs.getDouble("prix"))
             .append("}");
        }
        j.append("]");
        Util.json(ex, 200, j.toString());
    }

    private void creerLoc(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.body(ex);
        String rid = p.get("reservationId");
        PreparedStatement ps = DB.get().prepareStatement(
            "INSERT INTO LOCATION(chambre_id,client_id,employe_id,reservation_id,date_checkin,date_debut,date_fin)" +
            " VALUES(?,?,?,?,CURRENT_DATE,?,?) RETURNING location_id");
        ps.setInt(1, Integer.parseInt(p.get("chambreId")));
        ps.setInt(2, Integer.parseInt(p.get("clientId")));
        ps.setInt(3, Integer.parseInt(p.get("employeId")));
        if (rid!=null&&!rid.isEmpty()) ps.setInt(4, Integer.parseInt(rid));
        else ps.setNull(4, Types.INTEGER);
        ps.setDate(5, java.sql.Date.valueOf(p.get("dateDebut")));
        ps.setDate(6, java.sql.Date.valueOf(p.get("dateFin")));
        ResultSet rs = ps.executeQuery();
        rs.next();
        Util.json(ex, 200, "{\"success\":true,\"locationId\":"+rs.getInt(1)+"}");
    }
}