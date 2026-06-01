---
name: frontend-change-decisions
description: Use when 维护前端 OpenSpec change 的 decisions.md；汇总 Needs product/design/backend decision、记录 owner 拍板、更新 Gate 状态、整理阻塞问题；不替 owner 决策、不写架构设计、不生成任务、不写代码。
---

# 前端 Change 决策记录

## 定位

维护当前 OpenSpec change 的 `decisions.md`，把人工审查、owner 拍板和 Gate 状态沉淀成可追踪记录。

本 skill 只回答：

- 哪些 `Needs product/design/backend decision` 还没关闭。
- 哪些问题已经由 owner 明确拍板。
- 各 Gate 当前是 `Pending`、`Approved`、`Changes Required` 还是 `Blocked`。
- 哪些阻塞问题会影响后续 `design.md`、`tasks.md` 或实现。

它不做产品判断、UI 判断、接口判断、架构设计、任务拆解或代码实现。

## 硬性边界

- 不替用户、owner、产品、设计或后端做决策。
- 不把 Gate 改成 `Approved`，除非用户输入或已有文档有明确批准。
- 不新增产品事实、UI 事实或接口事实；事实变化应回写对应 `docs/*-requirements.md`。
- 不写 `design.md`、`tasks.md`、业务代码、测试或实现计划。
- 不用“看起来没问题”推断 Gate 通过。
- 冲突来源不足时，保持 `Pending` 或 `Blocked`，并记录阻塞问题。

## 输入

优先读取 active OpenSpec change 中的：

- `proposal.md`
- `docs/product-requirements.md`
- `docs/design-requirements.md`
- `docs/api-requirements.md`
- `docs/alignment-requirements.md`
- 现有 `decisions.md`

只把明确来源记录为 evidence。聊天里的口头结论只有在用户明确要求记录时，才写入 `decisions.md`。

## 输出

使用 `assets/templates/decisions.md` 作为基础模板，输出或更新：

```text
openspec/changes/<change-id>/decisions.md
```

文档只维护：

- Gate Status
- Decision Log
- Blocking Questions

允许的 Gate 状态：

- `Pending`
- `Approved`
- `Changes Required`
- `Blocked`

## 更新规则

- 已有决策不删除；需要修正时新增一条决策或把状态改为 superseded/changed，并保留来源。
- Gate evidence 必须指向文件路径、issue、PR、会议纪要或用户明确输入。
- `Implementation Gate` 只有在范围、产品、设计、接口和对齐阻塞项都被明确处理后，才能按 owner 指令改为 `Approved`。
- 如果缺少必要事实文件，只记录缺口，不创建虚假的通过状态。

## 最终回复

说明：

- `decisions.md` 路径。
- Gate 状态变化。
- 新增或更新的决策。
- 仍然阻塞的问题。

## 资源

- `assets/templates/decisions.md`
