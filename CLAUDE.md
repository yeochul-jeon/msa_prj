# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is an MSA (Microservices Architecture) transformation project planning repository. The primary focus is on conducting Domain Event Storming workshops to identify bounded contexts and prepare for microservices migration.

## Project Purpose

- Plan and execute Event Storming workshops with department leaders and senior developers
- Visualize and concretize domain areas currently operated by development departments
- Identify bounded contexts for MSA transformation
- Create a roadmap for migrating from monolithic architecture to microservices

## Documentation Structure

This repository contains comprehensive documentation for planning and conducting Event Storming workshops:

### 1. 이벤트스토밍_워크샵_계획서.md
Main planning document including:
- Workshop overview and objectives
- Participant requirements and timeline
- Preparation checklist (materials, communication, facilitation)
- Workshop schedule (1-day format with detailed timeline)
- Risk management and success criteria
- Post-workshop follow-up activities

### 2. 이벤트스토밍_단계별_실행가이드.md
Detailed step-by-step execution guide with:
- Pre-workshop preparation (D-7 checklist)
- Phase-by-phase instructions (8 phases total)
- Facilitation scripts and examples
- Troubleshooting scenarios
- Facilitator tips and best practices

### 3. 이벤트스토밍_시각화_가이드.md
Visual reference guide featuring:
- Process flow diagrams
- Post-it color coding system
- Event storming patterns and examples
- Bounded context visualization
- Complete workflow examples (e-commerce, banking)
- Context mapping patterns
- Digital tool recommendations

### 4. 이벤트스토밍_퀵레퍼런스.md
Quick reference guide with:
- 1-minute summary and terminology
- Common mistakes and solutions
- Facilitator cheat sheets
- Situation-specific response scripts
- Post-it writing examples (good vs bad)
- Workshop report templates
- Domain-specific event examples

## Key Concepts

### Event Storming Elements
- **Domain Events** (🟧 Orange): Significant business occurrences (past tense)
- **Commands** (🟦 Blue): Actions that trigger events (imperative)
- **Aggregates** (🟨 Yellow): Data models that change together
- **Policies** (💜 Purple): Automated business rules
- **Hotspots** (🩷 Pink): Issues or unclear areas
- **External Systems** (🟩 Green): Third-party integrations
- **Read Model** (📖 Light Blue): Data views optimized for queries
- **Bounded Contexts** (Large post-its): Microservice candidates

### Workshop Flow
1. Event Discovery → 2. Timeline Ordering → 3. Add Commands → 4. Add Aggregates → 5. Add Policies → 5.5. Identify Read Models → 6. Identify Bounded Contexts

## Usage Guidelines

When working with this project:

1. **For Workshop Planning**: Start with 이벤트스토밍_워크샵_계획서.md for overall structure and timeline
2. **For Execution**: Use 이벤트스토밍_단계별_실행가이드.md during the actual workshop
3. **For Visual Reference**: Refer to 이벤트스토밍_시각화_가이드.md for patterns and examples
4. **For Quick Lookup**: Use 이벤트스토밍_퀵레퍼런스.md for immediate answers

## Project Context

This is a planning and documentation project (no code). The output is intended to guide PMs and facilitators through the Event Storming process as the first step in an MSA transformation initiative.
