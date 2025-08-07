package com.login.visualizationsoftware.util;

import org.jfree.chart.ChartFactory;
import org.jfree.chart.JFreeChart;
import org.jfree.chart.plot.PlotOrientation;
import org.jfree.data.category.DefaultCategoryDataset;
import org.jfree.data.general.DefaultPieDataset;
import org.jfree.data.statistics.HistogramDataset;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.util.Map;
import org.jfree.chart.labels.StandardPieSectionLabelGenerator;
import org.jfree.chart.plot.PiePlot;
import org.jfree.chart.plot.XYPlot;

public class ChartUtils {

 public static BufferedImage createBarChart(String title, Map<String, Double> dataMap) {
    DefaultCategoryDataset dataset = new DefaultCategoryDataset();
    for (Map.Entry<String, Double> entry : dataMap.entrySet()) {
        dataset.addValue(entry.getValue(), "Values", entry.getKey());
    }

    JFreeChart chart = ChartFactory.createBarChart(
            title, "Category", "Value", dataset,
            PlotOrientation.VERTICAL, false, true, false);

    // Show labels on top of bars
    chart.getCategoryPlot().getRenderer().setDefaultItemLabelsVisible(true);
    chart.getCategoryPlot().getRenderer().setDefaultItemLabelFont(new Font("SansSerif", Font.BOLD, 12));
    chart.getCategoryPlot().getRenderer().setDefaultItemLabelPaint(Color.BLACK);

    chart.setBackgroundPaint(Color.white);
    return chart.createBufferedImage(800, 500);
}
public static BufferedImage createPieChart(String title, Map<String, Double> dataMap) {
    DefaultPieDataset dataset = new DefaultPieDataset();
    for (Map.Entry<String, Double> entry : dataMap.entrySet()) {
        dataset.setValue(entry.getKey(), entry.getValue());
    }

    JFreeChart chart = ChartFactory.createPieChart(
            title, dataset, true, true, false);

    // Show labels inside slices
    PiePlot plot = (PiePlot) chart.getPlot();
    plot.setLabelFont(new Font("SansSerif", Font.PLAIN, 12));
    plot.setSimpleLabels(false); // show detailed labels
    plot.setLabelGenerator(new StandardPieSectionLabelGenerator("{0}: {1} ({2})"));
    plot.setLabelPaint(Color.BLACK);

    chart.setBackgroundPaint(Color.white);
    return chart.createBufferedImage(800, 500);
}


    public static BufferedImage createLineChart(String title, Map<String, Double> dataMap) {
    DefaultCategoryDataset dataset = new DefaultCategoryDataset();
    for (Map.Entry<String, Double> entry : dataMap.entrySet()) {
        dataset.addValue(entry.getValue(), "Values", entry.getKey());
    }

    JFreeChart chart = ChartFactory.createLineChart(
            title, "Category", "Value", dataset,
            PlotOrientation.VERTICAL, false, true, false);

    // Show labels on points
    chart.getCategoryPlot().getRenderer().setDefaultItemLabelsVisible(true);
    chart.getCategoryPlot().getRenderer().setDefaultItemLabelFont(new Font("SansSerif", Font.BOLD, 12));
    chart.getCategoryPlot().getRenderer().setDefaultItemLabelPaint(Color.BLACK);

    chart.setBackgroundPaint(Color.white);
    return chart.createBufferedImage(800, 500);
}


  public static BufferedImage createHistogram(String title, Map<String, Double> dataMap) {
    HistogramDataset dataset = new HistogramDataset();

    double[] values = dataMap.values().stream()
            .mapToDouble(Double::doubleValue)
            .toArray();

    if (values.length == 0) values = new double[]{0}; // avoid crash

    dataset.addSeries("Frequency", values, 10); // 10 bins

    JFreeChart chart = ChartFactory.createHistogram(
            title, "Value", "Frequency", dataset,
            PlotOrientation.VERTICAL, false, true, false);

    XYPlot plot = (XYPlot) chart.getPlot();
    plot.setBackgroundPaint(Color.white);

    // Show frequency labels on bars
    chart.getXYPlot().getRenderer().setDefaultItemLabelsVisible(true);
    chart.getXYPlot().getRenderer().setDefaultItemLabelFont(new Font("SansSerif", Font.BOLD, 12));
    chart.getXYPlot().getRenderer().setDefaultItemLabelPaint(Color.BLACK);

    return chart.createBufferedImage(800, 500);
}

}
