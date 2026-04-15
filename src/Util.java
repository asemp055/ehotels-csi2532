import com.sun.net.httpserver.HttpExchange;
import java.io.*;
import java.util.*;

public class Util {

    public static void json(HttpExchange ex, int status, String json) throws IOException {
        byte[] bytes = json.getBytes("UTF-8");
        ex.getResponseHeaders().set("Content-Type", "application/json;charset=UTF-8");
        ex.getResponseHeaders().set("Access-Control-Allow-Origin", "*");
        ex.getResponseHeaders().set("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS");
        ex.getResponseHeaders().set("Access-Control-Allow-Headers", "Content-Type");
        ex.sendResponseHeaders(status, bytes.length);
        OutputStream os = ex.getResponseBody();
        os.write(bytes);
        os.close();
    }

    public static boolean cors(HttpExchange ex) throws IOException {
        if ("OPTIONS".equalsIgnoreCase(ex.getRequestMethod())) {
            ex.getResponseHeaders().set("Access-Control-Allow-Origin", "*");
            ex.getResponseHeaders().set("Access-Control-Allow-Methods", "GET,POST,PUT,DELETE,OPTIONS");
            ex.getResponseHeaders().set("Access-Control-Allow-Headers", "Content-Type");
            ex.sendResponseHeaders(204, -1);
            return true;
        }
        return false;
    }

    public static Map<String,String> query(HttpExchange ex) {
        Map<String,String> m = new HashMap<>();
        String q = ex.getRequestURI().getQuery();
        if (q == null || q.isEmpty()) return m;
        for (String p : q.split("&")) {
            String[] kv = p.split("=", 2);
            if (kv.length == 2) m.put(kv[0], dec(kv[1]));
        }
        return m;
    }

    public static Map<String,String> body(HttpExchange ex) throws IOException {
        Map<String,String> m = new HashMap<>();
        byte[] raw = ex.getRequestBody().readAllBytes();
        if (raw.length == 0) return m;
        String b = new String(raw, "UTF-8");
        for (String p : b.split("&")) {
            String[] kv = p.split("=", 2);
            if (kv.length == 2) m.put(kv[0], dec(kv[1]));
        }
        return m;
    }

    public static String esc(String s) {
        if (s == null) return "";
        return s.replace("\\","\\\\").replace("\"","\\\"").replace("\n","\\n").replace("\r","");
    }

    private static String dec(String s) {
        try { return java.net.URLDecoder.decode(s, "UTF-8"); }
        catch (Exception e) { return s; }
    }
}