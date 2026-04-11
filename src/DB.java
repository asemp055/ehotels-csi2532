import java.sql.*;

public class DB {
    private static final String URL  = "jdbc:postgresql://localhost:5432/ehotels";
    private static final String USER = "postgres";
    private static final String PASS = "Rolande1234";

    private static Connection conn;

    public static Connection get() throws SQLException {
        try {
            if (conn == null || conn.isClosed()) {
                Class.forName("org.postgresql.Driver");
                conn = DriverManager.getConnection(URL, USER, PASS);
                conn.setAutoCommit(true);
            }
        } catch (ClassNotFoundException e) {
            throw new SQLException("Driver PostgreSQL introuvable. Verifiez lib/postgresql.jar");
        }
        return conn;
    }
}