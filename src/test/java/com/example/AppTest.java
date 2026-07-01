package com.example;

import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;

public class AppTest {

    private HelloServlet servlet;

    @Before
    public void setUp() {
        servlet = new HelloServlet();
    }

    @Test
    public void testPipelineNotNull() {
        assertNotNull(servlet.getPipeline());
    }

    @Test
    public void testPipelineContainsJenkins() {
        assertTrue(servlet.getPipeline().contains("Jenkins"));
    }

    @Test
    public void testPipelineContainsMaven() {
        assertTrue(servlet.getPipeline().contains("Maven"));
    }

    @Test
    public void testPipelineContainsSonarQube() {
        assertTrue(servlet.getPipeline().contains("SonarQube"));
    }

    @Test
    public void testPipelineContainsTomcat() {
        assertTrue(servlet.getPipeline().contains("Tomcat"));
    }

    @Test
    public void testPipelineNotEmpty() {
        assertFalse(servlet.getPipeline().isEmpty());
    }
}
