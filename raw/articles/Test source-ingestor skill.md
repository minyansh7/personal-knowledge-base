---
title: "Test source-ingestor skill"
source: "test://source-ingestor"
author: Test
published:
created: 2026-04-05
description: "Test document for validating the source-ingestor skill workflow."
tags:
  - test
  - ingest
---
This is a test source for validating the source-ingestor skill. It describes the workflow for reading a source, updating an existing wiki page, creating a source note, updating index.md, and appending log.md.

The test source should be ingested by adding a concise new insight to the existing AI Agents market page, while preserving the existing wiki structure and avoiding duplicates.

## Key idea

- Ingestion tests should confirm the workflow, not the source content.
- The source note should be created in `wiki/source-notes/` and referenced in the index.
- The log entry should use the ingest entry format.
