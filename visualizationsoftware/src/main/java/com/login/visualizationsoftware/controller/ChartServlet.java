package com.login.visualizationsoftware.controller;

import com.login.visualizationsoftware.model.User;
import com.login.visualizationsoftware.util.ChartUtils;
import com.login.visualizationsoftware.util.CsvParser;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.util.Map;

@WebServlet("/chart") // This annotation fixes the 404 error
public class ChartServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        try {
            // Get data prepared by the UploadServlet from the session
            String filePath = (String) session.getAttribute("filePath");
            Integer labelIndex = (Integer) session.getAttribute("labelIndex");
            Integer valueIndex = (Integer) session.getAttribute("valueIndex");
            Integer limitCount = (Integer) session.getAttribute("limitCount");
            String currentFile = (String) session.getAttribute("currentFile");

            // Get the requested chart type from the URL parameter
            String chartType = request.getParameter("type");

            if (filePath == null || chartType == null) {
                // If session data is missing, send user to start over
                response.sendRedirect("upload.jsp");
                return;
            }

            // Parse the data from the CSV file
            Map<String, Double> dataMap = CsvParser.parse(filePath, labelIndex, valueIndex, limitCount);
            
            BufferedImage chartImage;
            String chartTypeName = getChartTypeName(chartType);

            // Use your excellent ChartUtils to create the image
            switch(chartType) {
                case "bar":
                    chartImage = ChartUtils.createBarChart(chartTypeName + " - " + currentFile, dataMap);
                    break;
                case "pie":
                    chartImage = ChartUtils.createPieChart(chartTypeName + " - " + currentFile, dataMap);
                    break;
                case "line":
                     chartImage = ChartUtils.createLineChart(chartTypeName + " - " + currentFile, dataMap);
                     break;
                case "histogram":
                     chartImage = ChartUtils.createHistogram(chartTypeName + " - " + currentFile, dataMap);
                     break;
                default:
                    throw new ServletException("Invalid chart type specified.");
            }

            // Set the final attributes needed by chart.jsp
            session.setAttribute("chartImage", chartImage);
            session.setAttribute("chartType", chartTypeName);
            
            // Redirect to the final output page
            response.sendRedirect("chart.jsp");

        } catch(Exception e) {
            System.err.println("CHART SERVLET FAILED:");
            e.printStackTrace();
            session.setAttribute("uploadError", "Error generating chart: " + e.getMessage());
            response.sendRedirect("upload.jsp");
        }
    }
    
    private String getChartTypeName(String shortName) {
        switch (shortName) {
            case "bar": return "Bar Chart";
            case "pie": return "Pie Chart";
            case "line": return "Line Chart";
            case "histogram": return "Histogram";
            default: return "Chart";
        }
    }
}