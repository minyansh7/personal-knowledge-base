---
title: Agent Development Kit (ADK)
source: https://adk.dev/?utm_source=chatgpt.com
author:
published:
created: 2026-04-05
description: Build powerful multi-agent systems with Agent Development Kit (ADK)
tags:
  - google-adk
  - agent
  - multi-agent
---
## Agent Development Kit

Agent Development Kit (ADK) is a flexible and modular framework for **developing and deploying AI agents**. While optimized for Gemini and the Google ecosystem, ADK is **model-agnostic**, **deployment-agnostic**, and is built for **compatibility with other frameworks**. ADK was designed to make agent development feel more like software development, to make it easier for developers to create, deploy, and orchestrate agentic architectures that range from simple tasks to complex workflows.

News: ADK Go 1.0.0 released!

ADK Go 1.0.0 release adds several major features, including OpenTelemetry integration, self-healing logic using plugins, and improved human input support. For more details on this release, see the [ADK Go v1.0 announcement](https://developers.googleblog.com/adk-go-10-arrives/).

News: ADK Java 1.0.0 released!

ADK Java 1.0.0 is now available! This release includes several bug fixes and enhancements. Read more about it in the [blog announcement](https://developers.googleblog.com/announcing-adk-for-java-100-building-the-future-of-ai-agents-in-java/). Upgrade to ADK Java 1.0.0 to take advantage of these enhancements and ensure optimal performance in your applications.

Get started:

`pip install google-adk`

`npm install @google/adk`

`go get google.golang.org/adk`

```xml
pom.xml<dependency>
    <groupId>com.google.adk</groupId>
    <artifactId>google-adk</artifactId>
    <version>1.0.0</version>
</dependency>
```
```js
build.gradledependencies {
    implementation 'com.google.adk:google-adk:1.0.0'
}
```

[Start with Python](https://adk.dev/get-started/python/) [Start with TypeScript](https://adk.dev/get-started/typescript/) [Start with Go](https://adk.dev/get-started/go/) [Start with Java](https://adk.dev/get-started/java/)

---

## Learn more

[Watch "Introducing Agent Development Kit"!](https://www.youtube.com/watch?v=zgrOwow_uTQ)

- **Flexible Orchestration**
	---
	Define workflows using workflow agents (`Sequential`, `Parallel`, `Loop`) for predictable pipelines, or leverage LLM-driven dynamic routing (`LlmAgent` transfer) for adaptive behavior.
	[**Learn about agents**](https://adk.dev/agents/)
- **Multi-Agent Architecture**
	---
	Build modular and scalable applications by composing multiple specialized agents in a hierarchy. Enable complex coordination and delegation.
	[**Explore multi-agent systems**](https://adk.dev/agents/multi-agents/)
- **Rich Tool Ecosystem**
	---
	Equip agents with diverse capabilities: use pre-built tools (Search, Code Exec), create custom functions, integrate 3rd-party libraries, or even use other agents as tools.
	[**Browse tools and integrations**](https://adk.dev/integrations/)
- **Deployment Ready**
	---
	Containerize and deploy your agents anywhere – run locally, scale with Vertex AI Agent Engine, or integrate into custom infrastructure using Cloud Run or Docker.
	[**Deploy agents**](https://adk.dev/deploy/)
- **Built-in Evaluation**
	---
	Systematically assess agent performance by evaluating both the final response quality and the step-by-step execution trajectory against predefined test cases.
	[**Evaluate agents**](https://adk.dev/evaluate/)
- **Building Safe and Secure Agents**
	---
	Learn how to building powerful and trustworthy agents by implementing security and safety patterns and best practices into your agent's design.
	[**Safety and Security**](https://adk.dev/safety/)