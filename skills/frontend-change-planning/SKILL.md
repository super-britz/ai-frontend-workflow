---
name: frontend-change-planning
description: Use when 一个前端需求过大、边界不清、可能需要拆成多个 OpenSpec change；适用于 PRD、Wiki、会议纪要或用户描述需要先做 change 拆分、阶段规划和依赖识别。
---

# 前端 Change 规划

## 目标

把较大的前端需求拆成多个边界清晰、可审核、可独立进入 OpenSpec 的 change 候选。

本 skill 只做 change 规划。它不创建 OpenSpec change，不写详细产品需求，不拆 Figma，不写 API 字段，不生成实现任务，不写代码。

## 何时使用

- 一个需求覆盖多个页面、流程、角色、权限、状态或接口。
- 用户给的是 PRD、Wiki、会议纪要、需求池或较大的业务目标。
- 不确定应该建一个 change 还是多个 change。
- 需要先确定交付阶段、依赖关系和推荐执行顺序。

如果需求已经足够小、边界清楚，可以直接使用 `frontend-openspec-workflow` 创建或整理对应 change。

## 拆分原则

一个 change 应该满足：

- 目标单一，能用一句话说明。
- 范围和非目标清楚。
- 可以独立审核、实现和验证。
- 依赖关系明确，不把多个互相独立的页面或流程强行放在一起。
- 不因为同一个 PRD 就默认合成一个 change。

优先按这些维度拆分：

- 用户路径或业务流程。
- 页面 / 模块 / 弹窗 / 后台能力。
- 角色、权限或租户差异。
- API 或后端依赖。
- 设计交付批次。
- 可独立上线的业务价值。

## 工作流程

### 1. 读取输入

按需读取：

- PRD、Wiki、需求单、会议纪要或用户描述。
- 已有 OpenSpec specs 或 active changes。
- 项目 `AGENTS.md`、README、业务文档和相似页面。

只使用来源中明确存在的信息。缺失但影响拆分的问题，标记 `Needs product/design/backend decision`。

### 2. 建立候选 change

对每个候选 change 写清：

- Change ID 建议。
- 目标。
- 范围。
- 非目标。
- 依赖。
- 风险。
- 推荐顺序。
- 是否需要产品、设计、API 或权限补充。

### 3. 检查拆分质量

发现以下情况时继续拆：

- 一个 change 包含多个独立用户目标。
- 一个 change 需要多个互不相关的接口或设计批次。
- 一个 change 无法在短周期内独立验证。
- 非目标写不清。

发现以下情况时合并：

- 两个 change 必须同时上线才有业务价值。
- 两个 change 的设计、接口和验收强绑定。
- 拆开后只剩技术步骤，没有独立业务意义。

### 4. 输出规划文档

默认输出到：

```text
docs/ai/frontend-change-plan.md
```

如果用户指定 OpenSpec 或项目已有其他规划路径，按项目约定保存。

使用 `assets/templates/frontend-change-plan.md` 作为基础模板。

## 最终回复

说明：

- 规划文档路径。
- 推荐拆出的 change 数量。
- 推荐先做哪个 change。
- 需要 owner 决策的问题。
- 下一步是否进入 `frontend-openspec-workflow`。

## 资源

- `assets/templates/frontend-change-plan.md`
