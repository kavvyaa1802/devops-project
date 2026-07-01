package com.example;

import org.junit.Test;
import org.junit.Before;
import static org.junit.Assert.*;

public class PipelineInfoTest {

    private PipelineInfo info;

    @Before
    public void setUp() {
        info = new PipelineInfo();
    }

    @Test
    public void testGetVersion() {
        assertEquals("1.0.0", info.getVersion());
    }

    @Test
    public void testGetStack() {
        assertNotNull(info.getStack());
        assertTrue(info.getStack().contains("Jenkins"));
        assertTrue(info.getStack().contains("Maven"));
        assertTrue(info.getStack().contains("SonarQube"));
        assertTrue(info.getStack().contains("Tomcat"));
    }

    @Test
    public void testGetAuthor() {
        assertEquals("Kavya Sri Nallani", info.getAuthor());
    }

    @Test
    public void testGetProject() {
        assertNotNull(info.getProject());
        assertTrue(info.getProject().contains("DevOps"));
    }

    @Test
    public void testGetCurrentTime() {
        String time = info.getCurrentTime();
        assertNotNull(time);
        assertTrue("Time should match format",
            time.matches("\\d{4}-\\d{2}-\\d{2} \\d{2}:\\d{2}:\\d{2}"));
    }

    @Test
    public void testIsVersionValidTrue() {
        assertTrue(info.isVersionValid("1.0.0"));
        assertTrue(info.isVersionValid("2.3.1"));
        assertTrue(info.isVersionValid("10.20.30"));
    }

    @Test
    public void testIsVersionValidFalse() {
        assertFalse(info.isVersionValid("invalid"));
        assertFalse(info.isVersionValid("1.0"));
        assertFalse(info.isVersionValid(""));
    }

    @Test
    public void testIsVersionValidNull() {
        assertFalse(info.isVersionValid(null));
    }

    @Test
    public void testFormatDeploymentInfo() {
        String result = info.formatDeploymentInfo("localhost", "Tomcat 10");
        assertEquals("Deployed on localhost using Tomcat 10", result);
    }

    @Test
    public void testFormatDeploymentInfoNullHost() {
        String result = info.formatDeploymentInfo(null, "Tomcat");
        assertEquals("Unknown deployment", result);
    }

    @Test
    public void testFormatDeploymentInfoNullContainer() {
        String result = info.formatDeploymentInfo("localhost", null);
        assertEquals("Unknown deployment", result);
    }
}
