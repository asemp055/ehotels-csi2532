import com.sun.net.httpserver.*;
import java.io.*;
import java.net.InetSocketAddress;
import java.nio.file.*;

public class Main {

    public static void main(String[] args) throws Exception {
        HttpServer server = HttpServer.create(new InetSocketAddress(8080), 0);

        ChambreHandler     ch = new ChambreHandler();
        ClientHandler      cl = new ClientHandler();
        EmployeHandler     em = new EmployeHandler();
        ReservationHandler rh = new ReservationHandler();

        server.createContext("/api/chambres",    ch);
        server.createContext("/api/hotels",      ch);
        server.createContext("/api/clients",     cl);
        server.createContext("/api/employes",    em);
        server.createContext("/api/reservation", rh);
        server.createContext("/api/location",    rh);
        server.createContext("/",                new StaticHandler());

        server.setExecutor(null);
        server.start();
        System.out.println("==========================================");
        System.out.println("  e-Hotels demarre : http://localhost:8080");
        System.out.println("  Ctrl+C pour arreter");
        System.out.println("==========================================");
    }

    static class StaticHandler implements HttpHandler {
        public void handle(HttpExchange ex) throws IOException {
            String path = ex.getRequestURI().getPath();
            String file;
            if (path.equals("/") || path.equals("/index.html")) {
                file = "frontend/index.html";
            } else if (path.equals("/gestion.html")) {
                file = "frontend/gestion.html";
            } else {
                ex.sendResponseHeaders(404, -1);
                return;
            }
            try {
                byte[] bytes = Files.readAllBytes(Paths.get(file));
                ex.getResponseHeaders().set("Content-Type", "text/html;charset=UTF-8");
                ex.sendResponseHeaders(200, bytes.length);
                OutputStream os = ex.getResponseBody();
                os.write(bytes);
                os.close();
            } catch (IOException e) {
                ex.sendResponseHeaders(404, -1);
            }
        }
    }
}