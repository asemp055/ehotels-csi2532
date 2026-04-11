import com.sun.net.httpserver.*;
import java.io.*;
import java.sql.*;
import java.util.*;

public class ClientHandler implements HttpHandler {

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
            "SELECT * FROM CLIENT ORDER BY nom_complet").executeQuery();
        StringBuilder j = new StringBuilder("[");
        boolean first=true;
        while (rs.next()) {
            if (!first) j.append(","); first=false;
            j.append("{")
             .append("\"clientId\":").append(rs.getInt("client_id")).append(",")
             .append("\"nomComplet\":\"").append(Util.esc(rs.getString("nom_complet"))).append("\",")
             .append("\"adresse\":\"").append(Util.esc(rs.getString("adresse"))).append("\",")
             .append("\"nas\":\"").append(Util.esc(rs.getString("nas"))).append("\",")
             .append("\"dateInscription\":\"").append(rs.getDate("date_inscription")).append("\"")
             .append("}");
        }
        j.append("]");
        Util.json(ex, 200, j.toString());
    }

    private void ajouter(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.body(ex);
        PreparedStatement ps = DB.get().prepareStatement(
            "INSERT INTO CLIENT(nom_complet,adresse,nas) VALUES(?,?,?) RETURNING client_id");
        ps.setString(1, p.get("nomComplet"));
        ps.setString(2, p.get("adresse"));
        ps.setString(3, p.get("nas"));
        ResultSet rs = ps.executeQuery();
        rs.next();
        Util.json(ex, 200, "{\"success\":true,\"clientId\":"+rs.getInt(1)+"}");
    }

    private void modifier(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.body(ex);
        PreparedStatement ps = DB.get().prepareStatement(
            "UPDATE CLIENT SET nom_complet=?,adresse=?,nas=? WHERE client_id=?");
        ps.setString(1, p.get("nomComplet"));
        ps.setString(2, p.get("adresse"));
        ps.setString(3, p.get("nas"));
        ps.setInt(4, Integer.parseInt(p.get("clientId")));
        ps.executeUpdate();
        Util.json(ex, 200, "{\"success\":true}");
    }

    private void supprimer(HttpExchange ex) throws Exception {
        Map<String,String> p = Util.query(ex);
        PreparedStatement ps = DB.get().prepareStatement("DELETE FROM CLIENT WHERE client_id=?");
        ps.setInt(1, Integer.parseInt(p.get("clientId")));
        ps.executeUpdate();
        Util.json(ex, 200, "{\"success\":true}");
    }
}