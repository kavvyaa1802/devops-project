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
    public void testBuildVersionNotNull() {
        assertNotNull("Build version should not be null",
            servlet.getBuildVersion());
    }

    @Test
    public void testBuildVersionValue() {
        assertEquals("Build version should be 1.0.0",
            "1.0.0", servlet.getBuildVersion());
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

    @Test
    public void testBuildVersionFormat() {
        String version = servlet.getBuildVersion();
        assertTrue("Version should match x.x.x format",
            version.matches("\\d+\\.\\d+\\.\\d+"));
    }
}
