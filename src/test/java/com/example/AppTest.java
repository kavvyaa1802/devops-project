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
        assertNotNull("Pipeline string should not be null",
            servlet.getPipeline());
    }

    @Test
    public void testPipelineContainsJenkins() {
        assertTrue("Pipeline should mention Jenkins",
            servlet.getPipeline().contains("Jenkins"));
    }

    @Test
    public void testPipelineContainsMaven() {
        assertTrue("Pipeline should mention Maven",
            servlet.getPipeline().contains("Maven"));
    }

    @Test
    public void testPipelineContainsSonarQube() {
        assertTrue("Pipeline should mention SonarQube",
            servlet.getPipeline().contains("SonarQube"));
    }

    @Test
    public void testPipelineContainsTomcat() {
        assertTrue("Pipeline should mention Tomcat",
            servlet.getPipeline().contains("Tomcat"));
    }
}
