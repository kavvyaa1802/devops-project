<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>DevOps Pipeline Demo — Kavya Sri Nallani</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
  <style>
    body { background: #0f172a; color: #e2e8f0; font-family: 'Segoe UI', sans-serif; }
    .hero { background: linear-gradient(135deg, #1e3a5f 0%, #0f172a 100%); padding: 80px 0 60px; }
    .badge-tool { font-size: 0.95rem; padding: 8px 16px; border-radius: 20px; margin: 4px; display: inline-block; }
    .author-badge { background: #1e293b; border: 1px solid #3b82f6; border-radius: 30px;
                    padding: 8px 20px; display: inline-block; margin-bottom: 24px; }
    .card-dark { background: #1e293b; border: 1px solid #334155; border-radius: 12px; }
    .pipeline-step { background: #1e293b; border: 1px solid #334155; border-radius: 10px;
                     padding: 20px; text-align: center; transition: transform 0.2s; min-width: 110px; }
    .pipeline-step:hover { transform: translateY(-4px); border-color: #3b82f6; }
    .pipeline-arrow { font-size: 1.5rem; color: #3b82f6; align-self: center; }
    .status-dot { width: 10px; height: 10px; border-radius: 50%; background: #22c55e;
                  display: inline-block; margin-right: 6px; animation: pulse 2s infinite; }
    @keyframes pulse { 0%,100%{opacity:1} 50%{opacity:0.4} }
    .stat-card { background: #0f172a; border-radius: 10px; padding: 20px; text-align: center; }
    footer { background: #020617; padding: 24px 0; color: #64748b; font-size: 0.85rem; }
    .divider { border-color: #334155; }
  </style>
</head>
<body>

<!-- Hero -->
<div class="hero text-center">
  <div class="container">
    <span class="badge bg-success mb-3"><span class="status-dot"></span>Pipeline Active</span>
    <h1 class="display-4 fw-bold text-white mb-2">DevOps CI/CD Pipeline</h1>

    <!-- Author tag -->
    <div class="mb-3">
      <span class="author-badge">
        <span style="color:#94a3b8;font-size:0.85rem;">Final Year Project by</span>
        <span style="color:#60a5fa;font-weight:700;font-size:1rem;margin-left:8px;">Kavya Sri Nallani</span>
      </span>
    </div>

    <p class="lead text-secondary mb-4">Automated Build, Code Analysis &amp; Deployment on AWS EC2</p>
    <div>
      <span class="badge-tool bg-primary text-white">Jenkins</span>
      <span class="badge-tool bg-warning text-dark">Maven</span>
      <span class="badge-tool bg-info text-dark">SonarQube</span>
      <span class="badge-tool bg-danger text-white">Tomcat</span>
      <span class="badge-tool bg-secondary text-white">AWS EC2</span>
      <span class="badge-tool" style="background:#24292e;color:white">GitHub</span>
    </div>
  </div>
</div>

<!-- Pipeline Steps -->
<div class="container my-5">
  <h3 class="text-center text-white mb-4">How the Pipeline Works</h3>
  <div class="d-flex flex-wrap justify-content-center align-items-center gap-2">
    <div class="pipeline-step">
      <div style="font-size:2rem">📦</div>
      <div class="fw-bold text-white mt-2">GitHub</div>
      <small class="text-secondary">Code Push</small>
    </div>
    <div class="pipeline-arrow">→</div>
    <div class="pipeline-step">
      <div style="font-size:2rem">⚙️</div>
      <div class="fw-bold text-white mt-2">Jenkins</div>
      <small class="text-secondary">CI Trigger</small>
    </div>
    <div class="pipeline-arrow">→</div>
    <div class="pipeline-step">
      <div style="font-size:2rem">🔨</div>
      <div class="fw-bold text-white mt-2">Maven</div>
      <small class="text-secondary">Build + Test</small>
    </div>
    <div class="pipeline-arrow">→</div>
    <div class="pipeline-step">
      <div style="font-size:2rem">🔍</div>
      <div class="fw-bold text-white mt-2">SonarQube</div>
      <small class="text-secondary">Code Analysis</small>
    </div>
    <div class="pipeline-arrow">→</div>
    <div class="pipeline-step">
      <div style="font-size:2rem">🚀</div>
      <div class="fw-bold text-white mt-2">Tomcat</div>
      <small class="text-secondary">Auto Deploy</small>
    </div>
    <div class="pipeline-arrow">→</div>
    <div class="pipeline-step" style="border-color:#22c55e">
      <div style="font-size:2rem">🌐</div>
      <div class="fw-bold text-white mt-2">Live App</div>
      <small class="text-secondary">You're here!</small>
    </div>
  </div>
</div>

<!-- Live Server Info -->
<div class="container my-5">
  <div class="card-dark p-4">
    <h5 class="text-white mb-3">📊 Live Deployment Info</h5>
    <div class="row g-3">
      <div class="col-md-3">
        <div class="stat-card">
          <div class="text-secondary small">Server Time</div>
          <div class="text-white fw-bold mt-1">
            <%= LocalDateTime.now().format(DateTimeFormatter.ofPattern("HH:mm:ss")) %>
          </div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="stat-card">
          <div class="text-secondary small">Host</div>
          <div class="text-white fw-bold mt-1"><%= request.getServerName() %></div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="stat-card">
          <div class="text-secondary small">Java Version</div>
          <div class="text-white fw-bold mt-1"><%= System.getProperty("java.version") %></div>
        </div>
      </div>
      <div class="col-md-3">
        <div class="stat-card">
          <div class="text-secondary small">Servlet Container</div>
          <div class="text-white fw-bold mt-1"><%= application.getServerInfo() %></div>
        </div>
      </div>
    </div>
    <div class="text-center mt-4">
      <a href="hello" class="btn btn-primary me-2">Test Servlet →</a>
    </div>
  </div>
</div>

<!-- Footer -->
<footer class="text-center">
  <div class="container">
    <div class="mb-1">
      <span style="color:#60a5fa;font-weight:600;">Kavya Sri Nallani</span>
      <span style="color:#475569;margin:0 8px;">·</span>
      <span>Final Year DevOps Project</span>
    </div>
    <div>Deployed automatically via Jenkins CI/CD · AWS EC2 · Apache Tomcat 10.1</div>
  </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
