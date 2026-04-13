# Original Skill Creation Prompt

I want to create a shared skill that will be used across all my projects named repo-docs. This skill will teach the agent how to use/update docs within my repos. Every repo's agents.md will reference this skill on every single call.

AGENTS.md -> read this skill -> WORK_IN_PROGRESS.md -> a plan file -> relevant spec file(s) -> code implementation

## Docs Directory (/docs)

- Lives at the root of the repo.
- Contains a set of concise, but thorough markdown files such as plans and spec documents used by both humans and AI agents to work in this project. These are living documents that MUST be updated in conjunction with the code changes we make.
- These files should strive to be concise and to the point. Caveman style. Do not include bloated background information. Always answer the "what" and potentially the "why" if necessary.
- Any human or AI that understands English should be able to read these docs and understand how the application works.
- No changeset is complete until the documentation accurately reflects the new state of the code base.
- Progressive disclosure is a foundation principle of how the documentation MUST be structured. When A human or an AI agent has a task and wants to understand how the code base works. The structured nature of this documentation should make it fast and efficient for them to get to the specific information they need without a bunch of unnecessary context that's irrelevant to their task.
- These markdown files should heavily leverage the built-in features of markdown. For example, Markdown supports headings, which imply importance and hierarchy. Markdown supports bold text, which implies significance. Linking is a core component of markdown. Our entire progressive disclosure strategy relies on properly scoped files that properly link to each other. We should highly value these features and leverage them to structure our documentation accordingly to maximize its value to both humans and AI agents.
- When these docs link to other markdown docs in the repo, use relative markdown paths from the current file. Do not use filesystem absolute paths or repo-root paths like `/docs/...`.
- As these are living documents, as the project changes, not only should the documents themselves change, but the folder structure might also warrant a change. You are free to restructure at any time to maximize the progressive disclosure and overall clarity of the documentation. If you make a change to the folder structure or file names, make sure to update all links accordingly.
- plans
  - docs/plans
    - As we evolve the app over time and add new features, we will often need to create a plan before implementation. This is where we identify/document the current applicable application state, document the new desired state/requirements, and document a step by step plan that an agent can iterate through to accomplish the goal.
    - Should include minimal/no direct code references, as linking to the relevant spec docs will lead to the relevant code (progressive disclosure).
    - Focused on the "what" and the "why". In this document, explaining why we are making a change is just as important as the change itself. If you don't know why, ask the user.
    - A completed plan is durable history for that scope of work. Do not overwrite it with new scope. If more work is discovered, either add it to the existing plan when it is truly same scope, or create a new plan.
  - docs/plans/archived
    - As plans are completed, they are moved to the archived directory to keep the main plans directory narrow and focused on current and upcoming work.
    - No need to traverse these documents unless we are looking to understand when/where/why something was done in the past.
  - File Structure:
    - File naming convention: `[relevant-part-of-code]-[brief-description]-plan.md`
    - First line is the plan title
    - Underneath are timestamps for document creation and last updated (use Los Angeles time).
    - First section is "TLDR" summary. Up to a few brief sentences summarizing the change request and why.
    - Next is the "Current State" section. Briefly describes only the parts of the application relevant to the change request. Contains links to the relevant documentation in docs/specs (progressive disclosure).
    - Next is the "Desired State" section. This is the "what" and describes the future state of the relevant parts of the application. What are we trying to achieve?
    - Next is the "Goals" section, which should explain the "why" behind the change. What is the expected impact of this change?
    - Next is the "Options Considered" section. This will first show the selected option, followed by the other options considered. Each option should include a brief list of pros/cons/tradeoffs.
    - Last is the "Unknowns/Risks/Questions" section. This is where we document any unknowns, risks, or questions that we have related to the change. Ideally all of these are resolved before implementation.
    - Next is "Changes to be made" section. This is the step by step checklist plan that an agent will follow to get from the "Current State" to the "Desired State" and accomplish the goal(s).
- specs
  - docs/specs
    - Most important files in the repo. They are the source of truth that defines how code is intended to work. The source code is derived from these documents. spec docs -> source code.
    - Describe the current implementation of the feature. Not a 1/1 mapping to the source code, but just thorough enough to derive the desired feature set so it can be effectively implemented in the source code.
    - Generally a document per "feature" or area of the code base, but the agent has full autonomy to determine the best way to break up the specs into documents and how to link them together for optimal progressive disclosure, but only based on change requests from the human. It is the agent's responsibility to own the structure of the docs/specs directory and to evolve it as needed as the user requests changes. This includes creating/deleting/merging/moving spec docs as needed, as well as being responsible for ensuring all links are updated as needed.
    - Avoid background information or bloated context. The goal is to define the requirements of the source code that is quick to navigate to what is relevant; always facilitate this goal. Be concise and to the point.
    - If there is ever a conflict between the spec docs and the code implementation, notify the user immediately. Inform them of the conflict and ask what the correct direction is going forward. Update both the documentation and code implementation to match the decision that was made.
    - File Structure:
      - File naming convention: `*-spec.md`
      - First line is the spec title
      - Underneath are timestamps for document creation and last updated (use Los Angeles time).
      - First section is "TLDR" summary. Up to a few brief sentences summarizing the feature/area of the code.
      - The second is a "Contents" section that contains links to subheadings within the document. Used for progressive disclosure and quick navigation.
      - The middle part of the document:
        - 100% the responsibility of the agent to decide how to structure.
        - Highly value and leverage markdown features to represent hierarchy (heading tags), importance/significance (bold), and relationships (links).
          - Most important information should be at the top of the document. Less important information should be towards the bottom.
          - Link to relevant code files, but do not include the code itself in these spec docs. The links are enough for an agent to find the relevant code (progressive disclosure). The goal is to make it easy for both humans and agents to quickly find the relevant information they need.
      - The last section is "Other Relevant Spec Documents", which provides links to 2-4 other spec docs that are the most relevant to the current document(discoverability/progressive disclosure)
- TODO.md
  - A human edited document for tracking todo items
  - Agent can read, but not write.
  - Intentionally not linked as part of the progressive disclosure workflow.
- FEATURE_IDEAS.md
  - A human edited document for tracking future feature ideas
  - Agent can read, but not write.
  - Intentionally not linked as part of the progressive disclosure workflow.
- WORK_IN_PROGRESS.md
  - Always reflects the current work in progress. Could contain more than one unrelated items if parallel work is being done.
  - Always links back to a plan in docs/plans or directly to spec docs if no relevant plan exists. (progressive disclosure)
  - Should include minimal/no direct code references, as linking to the relevant plan/spec docs will lead to the relevant code

Ask me any questions you have to clarify how this system should work to make the skill you produce as useful as possible.
