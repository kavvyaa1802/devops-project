package com.example;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@WebServlet("/hello")
public class HelloServlet extends HttpServlet {
    private static final String BUILD_VERSION = "1.0.0";
    private static final String PIPELINE = "Jenkins → Maven → SonarQube → Tomcat";
    private static final String CLOSE_SPAN_DIV = "</span></div>";
    private static final String OPEN_INFO_ROW = "<div class='info-row'><span class='info-label'>";
    private static final String MID_INFO_ROW = "</span><span class='info-value'>";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws IOException, ServletException {
        try {
            resp.setContentType("text/html;charset=UTF-8");
            PrintWriter out = resp.getWriter();
            String time = LocalDateTime.now()
                .format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
            String clientIp = req.getRemoteAddr();

            out.println("<!DOCTYPE html><html><head><title>Pipeline Servlet</title>");
            out.println("<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css' rel='stylesheet' integrity='sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM' crossorigin='anonymous'>");
            out.println("<style>");
            out.println("body{background:#0f172a;color:#e2e8f0;}");
            out.println(".info-card{background:#1e293b;border:1px solid #334155;border-radius:12px;padding:30px;}");
            out.println(".info-row{display:flex;justify-content:space-between;padding:12px 0;border-bottom:1px solid #334155;}");
            out.println(".info-row:last-child{border-bottom:none;}");
            out.println(".info-label{color:#94a3b8;font-weight:500;}");
            out.println(".info-value{color:#f1f5f9;font-weight:600;}");
            out.println("</style></head>");
            out.println("<body class='p-5'><div class='container' style='max-width:700px'>");
            out.println("<h2 class='mb-1' style='color:#22c55e'>✅ Servlet Response</h2>");
            out.println("<p style='color:#94a3b8' class='mb-4'>Deployed via Jenkins CI/CD Pipeline</p>");
            out.println("<div class='info-card'>");
            out.println(OPEN_INFO_ROW + "Message" + MID_INFO_ROW + "Hello from Jenkins CI/CD Pipeline!" + CLOSE_SPAN_DIV);
            out.println(OPEN_INFO_ROW + "Build Version" + MID_INFO_ROW + BUILD_VERSION + CLOSE_SPAN_DIV);
            out.println(OPEN_INFO_ROW + "Pipeline" + MID_INFO_ROW + PIPELINE + CLOSE_SPAN_DIV);
            out.println(OPEN_INFO_ROW + "Timestamp" + MID_INFO_ROW + time + CLOSE_SPAN_DIV);
            out.println(OPEN_INFO_ROW + "Client IP" + MID_INFO_ROW + clientIp + CLOSE_SPAN_DIV);
            out.println("</div>");
            out.println("<a href='.' class='btn btn-primary mt-4'>← Back to Home</a>");
            out.println("</div></body></html>");
        } catch (IOException e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Error generating response: " + e.getMessage());
        }
    }

    public String getBuildVersion() { return BUILD_VERSION; }
    public String getPipeline() { return PIPELINE; }
}
