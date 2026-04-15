import com.sun.net.httpserver.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class EmployeHandler implements HttpHandler {

    public void handle(HttpExchange ex) throws IOException {
        if (Util.cors(ex)) return;
        try {
            switch (ex.getRequestMethod()) {
                case "GET"    -> lister(ex);
                case "POST"   -> ajouter(ex);
                case "PUT"    -> modifier(ex);
                case "DELETE" -> supprimer(ex);
                default       -> Util.json(ex, 405, "{\"erreur\":\"methode non supportee\"}");
            }
        } catch (Exception e) {
            e.printStackTrace();
            try { Util.json(ex, 500, "{\"erreur\":\""+Util.esc(e.getMessage())+"\"}"); }
            catch (IOException ignored) {}
        }
    }

    private void lister(HttpExchange ex) throws Exception {
        ResultSet rs = DB.get().prepareStatement(
            "SELECT e.*, h.adresse AS hotel FROM EMPLOYE e" +
            " JOIN HOTEL h ON e.hotel_id=h.hotel_id ORDER BY e.nom_complet").executeQuery();
        StringBuilder j = new StringBuilder("[");
        boolean first=true;
        while (rs.next()) {
            if (!first) j.append(","); first=false;
            j.append("{")
             .append("\"employeId\":").append(rs.getInt("employe_id")).append(",")
             .append("\"nomComplet\":\"").append(Util.esc(rs.getString("nom_complet"))).append("\",")
             .append("\"adresse\":\"").append(Util.esc(rs.getString("adresse"))).append("\",")
             .append("\"nas\":\"").append(Util.esc(rs.getString("nas"))).append("\",")
             .append("\"role\":\"").append(Util.esc(rs.getString("role"))).append("\",")
             .append("\"hotelId\":").append(rs.getInt("hotel_id")).append(",")
             .append("\"hotel\":\"").append(Util.esc(rs.getString("hotel"))).append("\"")
             .append("}");
        }
        j.append("]");
        Util.json(ex, 200, j.toString());
    }

    private void ajouter(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.body(ex);
        PreparedStatement ps = DB.get().prepareStatement(
            "INSERT INTO EMPLOYE(hotel_id,nom_complet,adresse,nas,role) VALUES(?,?,?,?,?) RETURNING employe_id");
        ps.setInt(1, Integer.parseInt(p.get("hotelId")));
        ps.setString(2, p.get("nomComplet"));
        ps.setString(3, p.get("adresse"));
        ps.setString(4, p.get("nas"));
        ps.setString(5, p.get("role"));
        ResultSet rs = ps.executeQuery();
        rs.next();
        Util.json(ex, 200, "{\"success\":true,\"employeId\":"+rs.getInt(1)+"}");
    }

    private void modifier(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.body(ex);
        PreparedStatement ps = DB.get().prepareStatement(
            "UPDATE EMPLOYE SET nom_complet=?,adresse=?,nas=?,role=?,hotel_id=? WHERE employe_id=?");
        ps.setString(1, p.get("nomComplet"));
        ps.setString(2, p.get("adresse"));
        ps.setString(3, p.get("nas"));
        ps.setString(4, p.get("role"));
        ps.setInt(5, Integer.parseInt(p.get("hotelId")));
        ps.setInt(6, Integer.parseInt(p.get("employeId")));
        ps.executeUpdate();
        Util.json(ex, 200, "{\"success\":true}");
    }

    private void supprimer(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.query(ex);
        PreparedStatement ps = DB.get().prepareStatement("DELETE FROM EMPLOYE WHERE employe_id=?");
        ps.setInt(1, Integer.parseInt(p.get("employeId")));
        ps.executeUpdate();
        Util.json(ex, 200, "{\"success\":true}");
    }
}