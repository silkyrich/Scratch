# Node Surfacing Audit: Americas Regional Study (GS-GE-KS2-003)

**Purpose:** Reverse-engineer every node type, attribute, and relationship visible in the exported markdown, then identify what the model likely holds but the prompt/website failed to surface.

**Principle:** Squeeze the stone dry before adding new content.

---

## Part 1: Node Types Identified in the Export

The following node types can be inferred from the exported output. For each, I list every attribute that IS visible, then flag what's likely present in the model but NOT pulled through.

---

### Node 1: `GeoStudy`
**Evidence:** Header block, graph context section
**Instance:** `GS-GE-KS2-003`

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `study_id` | GS-GE-KS2-003 | Visible in header and graph context |
| `subject` | Geography | Header |
| `key_stage` | KS2 | Header |
| `statutory_reference` | NC KS2 Geography: 'understand geographical...' | Full NC quote |
| `source_document` | Geography (KS1/KS2) - National Curriculum Programme of Study | Header |
| `estimated_duration` | 6 lessons | Header |
| `study_type` | Place Study | Header |
| `status` | Mandatory | Header |
| `planner_coverage` | 9/13 expected capabilities surfaced | Header meta |
| `available_capabilities` | (list of 9) | Header meta |
| `missing_capabilities` | (list of 4) | Header meta |
| `enquiry_questions` | (list of 1) | Single question |
| `scale` | Regional | Study scope |
| `themes` | regional geography, cross-continental comparison, biodiversity, human-physical interaction | Study scope |
| `map_types` | atlas map, thematic map, satellite image, climate graph | Study scope |
| `data_sources` | Atlas, World Bank, NASA Earth Observatory, Google Earth | Study scope |
| `assessment_guidance` | (3 questions) | Study scope |
| `why_this_study_matters` | (paragraph) | Rationale section |
| `pitfalls` | (list of 3) | Pitfalls section |
| `sensitive_content` | (2 items with guidance) | Sensitivity section |
| `success_criteria` | (list of 4) | Success criteria section |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `year_group` | KS2 spans Y3-Y6; the model must know which year(s) this targets | Can't pull year-group teaching guidance |
| `year_group_teaching_guidance` | **User confirmed this exists** — "how to teach year X staff attached to the year" | Tone, scaffolding expectations, pupil independence level, writing expectations all missing |
| `term` / `half_term` | Sequencing says "Follows: European Regional Study" — the model likely knows when in the year | Affects resource availability, cross-curricular timing |
| `total_teaching_hours` | "6 lessons" but no lesson duration — the model likely holds this | Teachers need to know 1-hour or 45-min lessons |
| `national_curriculum_aim` | NC has 3 overarching aims; this study likely maps to specific ones | Missing curriculum-level justification |
| `enquiry_questions` (additional) | Only 1 surfaced; place studies typically need 3-6 sub-questions | Can't structure lessons around enquiry progression |
| `final_output_specification` | The study type node (Place Study) likely has a more detailed output template | "Place study report" is too vague |
| `selected_region` | May not exist yet — but the model holds exemplar regions with attributes | Can't generate specific content |

---

### Node 2: `Concept`
**Evidence:** Concepts section, graph context
**Instances:** GE-KS2-C001 through GE-KS2-C006

#### Attributes surfaced (primary concept C006 only — secondary concepts truncated)

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `concept_id` | GE-KS2-C006 | Graph context |
| `name` | Regional Place Study and Cross-Continental Comparison | Concepts section |
| `type` | Skill | Concepts section |
| `teaching_weight` | 2/6 | Concepts section |
| `description` | (full paragraph) | Detailed |
| `teaching_guidance` | (full paragraph) | Detailed |
| `key_vocabulary` | (16 terms) | Listed |
| `common_misconceptions` | (2 misconceptions with guidance) | Detailed |
| `differentiation` | (4-level table: Entry/Developing/Expected/Greater Depth) | Very detailed |
| `model_responses` | (4 exemplar responses, one per level) | Detailed |

#### Attributes surfaced for secondary concepts (C001-C005)

| Attribute | Surfaced? | Notes |
|-----------|-----------|-------|
| `concept_id` | Yes | Listed in graph context |
| `name` | Yes | Listed |
| `description` | **Truncated** — cut off with "..." | Only ~15 words shown per concept |
| `type` | **No** | Not shown for secondary concepts |
| `teaching_weight` | **No** | Not shown for secondary concepts |
| `teaching_guidance` | **No** | Not shown for secondary concepts |
| `key_vocabulary` | **No** | Not shown for secondary concepts |
| `common_misconceptions` | **No** | Not shown for secondary concepts |
| `differentiation` | **No** | Not shown for secondary concepts |
| `model_responses` | **No** | Not shown for secondary concepts |

**THIS IS A MAJOR SURFACING FAILURE.** Five concepts have their full data in the model (they must — they're the same node type as C006) but the export only shows ~15 words of each. The prompt/template is truncating secondary concepts to stubs.

#### Attributes likely in model but NOT surfaced (for any concept)

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `prerequisite_concepts` | Prior knowledge table shows dependencies | Could auto-generate retrieval starters |
| `assessment_criteria` | Differentiation table implies criteria exist per level | Not structured as formal assessment |
| `lesson_allocation` | Teaching weight is 2/6 — model likely knows which lessons | Can't build lesson-level plans |
| `cognitive_demand` | Thinking lens is attached — but per-concept demand level may exist | Missing from differentiation guidance |

---

### Node 3: `DifficultyLevel`
**Evidence:** Differentiation table, graph context Cypher query
**Instances:** Entry, Developing, Expected, Greater Depth

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `label` | Entry / Developing / Expected / Greater Depth | Table rows |
| `description` | "What success looks like" column | Per-concept per-level |
| `example_task` | "Example task" column | Per-concept per-level |
| `common_errors` | "Common errors" column | Per-concept per-level |
| `model_response` | Blockquote examples | Per-concept per-level |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `sentence_stems` | Scaffolding is a known gap — but stems may exist at difficulty level | Missing scaffolding for Entry/Developing pupils |
| `success_threshold` | Assessment alignment is flagged missing — but thresholds may exist | Can't formally assess |
| `teacher_prompts` | "What to say to move pupils up" is standard differentiation data | Teachers can't intervene precisely |
| `worked_example` | Model responses exist but aren't framed as teaching tools | Could be surfaced as "show this to pupils" |

---

### Node 4: `ThinkingLens`
**Evidence:** Thinking lens section
**Instance:** Scale, Proportion and Quantity (primary); Evidence and Argument (secondary)

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `name` | Scale, Proportion and Quantity | Section header |
| `key_question` | "How big, how many, or how much..." | Detailed |
| `why_this_fits` | (paragraph) | Study-specific rationale |
| `question_stems` | (4 stems for KS2) | Listed |
| `secondary_lens` | Evidence and Argument | Named |
| `secondary_rationale` | (sentence) | Brief |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `secondary_lens_question_stems` | Primary lens has 4 stems; secondary lens likely does too | Can't use secondary lens in lessons |
| `per_concept_application` | Lens likely maps to specific concepts | Generic application, not targeted |
| `pupil_facing_version` | KS2 stems exist but may have simpler pupil-facing variants | Stems only usable by teachers |

---

### Node 5: `SessionStructure` (Study Type Template)
**Evidence:** Session structure section
**Instance:** Place Study

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `name` | Place Study | Section header |
| `description` | (paragraph) | General |
| `phases` | orientation → mapping → data_collection → analysis → comparison → evaluation | Sequence |
| `assessment` | (general description) | Vague |
| `teacher_note` | (paragraph) | Generic template guidance |
| `question_stems` | (4 KS2 stems) | Listed |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `phase_descriptions` | 6 phases named but not described — each likely has detail | Phases are labels not instructions |
| `phase_duration` | 6 phases, 6 lessons — mapping likely exists | Can't plan time |
| `phase_objectives` | Each phase likely has a learning objective | Can't set lesson objectives |
| `phase_pupil_output` | Each phase likely defines what pupils produce | Can't track progress |
| `phase_assessment_focus` | Each phase likely has assessment expectations | Can't check understanding |
| `output_specification` | "Place study report..." is vague — a detailed template likely exists | Final product undefined |
| `output_components` | Template likely lists required components | Teachers improvise |
| `model_output` | An exemplar final product likely exists or could be generated | No destination to work toward |

**THIS IS A SIGNIFICANT SURFACING FAILURE.** The Place Study template is rendered as a paragraph when it likely contains structured phase-level data that would directly address the "no lesson-by-lesson breakdown" criticism.

---

### Node 6: `Location`
**Evidence:** Locations section
**Instance:** Americas Region (Multiple)

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `name` | Americas Region | Section header |
| `type` | region | Parenthetical |
| `scale` | regional | Parenthetical |
| `suggested_exemplars` | (5 regions) | Listed |
| `key_physical_features` | "Determined by school choice" | Placeholder |
| `key_human_features` | "Determined by school choice" | Placeholder |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `exemplar_region_nodes` | Each exemplar (Amazon, California, etc.) likely exists as its own node with detailed attributes | **This is where specific knowledge lives** — and none of it is surfaced |
| `exemplar.physical_features` | Per-region physical geography | Can't teach specific content |
| `exemplar.human_features` | Per-region human geography | Can't teach specific content |
| `exemplar.climate_data` | Per-region climate information | Can't use data in lessons |
| `exemplar.key_facts` | Per-region core knowledge | Can't set knowledge expectations |
| `exemplar.map_resources` | Per-region suggested maps | Can't plan resources |
| `exemplar.comparison_points` | How each region compares with UK/Europe | Can't structure comparison |
| `exemplar.rationale` | Why each region is a good choice | Can't help teachers choose |
| `latitude` / `longitude` | Geographic coordinates | Can't do coordinate work |
| `country` | Brazil, USA, Argentina, Jamaica, Peru/Chile | Not explicitly linked |
| `continent` | North America / South America | Not explicitly linked |

**THIS MAY BE THE SINGLE BIGGEST SURFACING FAILURE.** If exemplar region nodes exist with detailed attributes, the entire "no chosen region" criticism could be partially addressed by surfacing those nodes fully — letting teachers see the rich data for each option and make an informed choice. The export says "Determined by school choice" when the model may actually hold the data.

---

### Node 7: `Skill` (Geographical Skills)
**Evidence:** Geographical skills section
**Instances:** 6 skills listed

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `name` | e.g. "Using compass directions and locational language" | Listed |
| `description` | (paragraph each) | Detailed |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `skill_id` | Every other node type has an ID | Can't reference or link |
| `key_stage` | Skills are KS2-specific | Already implicit |
| `concept_links` | Skills likely map to concepts | Can't assign skills to lessons via concepts |
| `progression` | KS1→KS2 skill progression likely exists | Can't show prior skill level |
| `assessment_indicators` | How to know if skill is demonstrated | Can't assess skills |
| `example_activities` | Activities that develop this skill | Can't plan skill-building tasks |
| `resources_needed` | Maps, atlases, fieldwork equipment | Can't plan resources |

---

### Node 8: `CrossCurricularLink`
**Evidence:** Cross-curricular opportunities table
**Instances:** 3 links

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `link_name` | e.g. "Traditional Tales: Myths from Around the World" | Table |
| `subject` | English, History, Science | Table |
| `connection` | (brief description) | Table |
| `strength` | Moderate / Strong | Table |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `target_study_id` | The linked study likely has its own ID | Can't cross-reference |
| `suggested_timing` | When to make the link (which lesson/week) | Link is theoretical not practical |
| `shared_vocabulary` | Terms common to both subjects | Can't reinforce across subjects |
| `joint_activity` | A concrete cross-curricular task | Teachers must invent the connection |

---

### Node 9: `VocabularyTerm`
**Evidence:** Vocabulary word mat, concept key vocabulary, knowledge organiser
**Instances:** 85+ terms in word mat

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `term` | Listed | 85+ terms |
| `meaning` | **ALL EMPTY** | Every definition blank |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `definition` | **These almost certainly exist in the model** — the word mat structure has a "Meaning" column, and concepts have "Key vocabulary" | The most obviously broken surfacing in the entire export |
| `child_friendly_definition` | KS2 output likely needs age-appropriate definitions | Can't use with pupils |
| `tier` | Core / Supporting / Extended | List is bloated without tiering |
| `concept_link` | Which concept each term belongs to | Can't assign vocab to lessons |
| `pronunciation` | For unfamiliar terms (e.g. "biome", "meander") | Missing for EAL/SEND |
| `example_sentence` | Term used in context | Can't model usage |
| `image_url` | Visual vocabulary support | Missing for visual learners |
| `etymology` | Word roots for some terms | Nice-to-have, not critical |

**THIS IS THE MOST OBVIOUSLY BROKEN SURFACING.** 85+ terms with no definitions, when the underlying concept nodes contain vocabulary and the model almost certainly stores definitions.

---

### Node 10: `PriorKnowledge`
**Evidence:** Prior knowledge (retrieval plan) table
**Instances:** 5 entries

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `prior_knowledge_name` | e.g. "World Geography: Continents and Oceans" | Table |
| `for_concept` | Which concept requires it | Table |
| `description` | **Truncated** — cut off with "..." | Only ~15 words shown |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `full_description` | Descriptions are truncated | Teachers can't see what pupils should already know |
| `source_study_id` | Which earlier study taught this | Can't reference back |
| `retrieval_questions` | Questions to check prior knowledge | Can't do retrieval starters |
| `key_facts` | Specific facts pupils should recall | Can't target retrieval |
| `common_gaps` | Where prior knowledge is often weak | Can't plan intervention |

---

### Node 11: `KeyStage`
**Evidence:** Referenced throughout but never surfaced as its own section
**Instance:** KS2

#### Attributes surfaced

Only indirectly — "KS2" appears as a label. No KS-level node is rendered.

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `age_range` | 7-11 | Not shown |
| `year_groups` | Y3, Y4, Y5, Y6 | Not shown |
| `general_teaching_guidance` | KS-level pedagogy expectations | Missing |
| `assessment_framework` | KS2 assessment expectations (working towards/expected/greater depth) | Not structured into output |
| `writing_expectations` | What KS2 pupils can be expected to write | Missing |
| `independence_level` | How much scaffolding KS2 pupils typically need | Missing |

---

### Node 12: `YearGroup`
**Evidence:** User confirmed "how to teach year X staff attached to the year" exists
**Instance:** Likely Y5 or Y6

#### Attributes surfaced

**NOTHING.** The year group node is not surfaced anywhere in the export.

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `year` | Y5 or Y6 | Not shown — teachers don't know target year |
| `teaching_guidance` | **User confirmed this exists** | Tone, formality, scaffolding, expectations all missing |
| `typical_pupil_profile` | What Y5/Y6 pupils can typically do | Can't calibrate difficulty |
| `writing_stamina` | Expected writing length/complexity | Can't set output expectations |
| `reading_level` | Expected reading level for resources | Can't select appropriate texts |
| `attention_span` | Typical lesson structure for this age | Can't plan pacing |
| `prior_curriculum` | What they've covered in Y3-Y4 | Could auto-generate retrieval |
| `working_memory_expectations` | How many steps/items pupils can hold | Can't calibrate task complexity |
| `oracy_expectations` | Speaking and listening norms | Can't plan discussion |
| `common_send_profiles` | Typical SEND needs at this age | Can't plan inclusion |

**THIS IS A CRITICAL SURFACING FAILURE.** The year group node contains exactly the kind of pedagogical guidance that would address the "formal output" criticism and the scaffolding/inclusion gaps. It exists in the model and is not being queried.

---

### Node 13: `Sequencing` (Relationship)
**Evidence:** Sequencing section
**Instance:** "Follows: European Regional Study"

#### Attributes surfaced

| Attribute | Value in export | Notes |
|-----------|----------------|-------|
| `follows` | European Regional Study | Named |

#### Attributes likely in model but NOT surfaced

| Likely attribute | Why it probably exists | Impact of not surfacing |
|-----------------|----------------------|------------------------|
| `preceding_study_id` | The European study has its own ID | Can't cross-reference |
| `preceding_study_region` | Which European region was studied | Can't build comparison — this is critical for a comparative study |
| `following_study` | What comes after this unit | Can't plan forward |
| `gap_lessons` | How many lessons between studies | Can't plan spacing |
| `knowledge_to_carry_forward` | What from the European study feeds into this one | Can't plan retrieval |
| `comparison_framework` | How the two studies should be compared | Can't structure comparison work |

---

## Part 2: Relationship Types Identified

These are the edges between nodes visible in the export:

| Relationship | From → To | Surfaced? | Fully surfaced? |
|-------------|-----------|-----------|-----------------|
| `DELIVERS_VIA` | GeoStudy → Concept | Yes | Primary only — secondaries truncated |
| `HAS_DIFFICULTY_LEVEL` | Concept → DifficultyLevel | Yes | Primary only |
| `HAS_THINKING_LENS` | GeoStudy → ThinkingLens | Yes | Primary lens full, secondary lens stub |
| `HAS_SESSION_STRUCTURE` | GeoStudy → SessionStructure | Yes | Phases named but not described |
| `HAS_LOCATION` | GeoStudy → Location | Yes | Exemplars listed but not expanded |
| `FOLLOWS` | GeoStudy → GeoStudy | Yes | Name only — no attributes |
| `REQUIRES_PRIOR` | Concept → PriorKnowledge | Yes | Descriptions truncated |
| `HAS_CROSS_CURRICULAR` | GeoStudy → CrossCurricularLink | Yes | Basic attributes only |
| `HAS_VOCABULARY` | GeoStudy → VocabularyTerm | Yes | **Terms without definitions** |
| `HAS_SKILL` | GeoStudy → Skill | Yes | Name and description only |
| `BELONGS_TO_KEY_STAGE` | GeoStudy → KeyStage | Implicit | Not rendered as a node |
| `BELONGS_TO_YEAR_GROUP` | GeoStudy → YearGroup | **NOT SURFACED** | **Not rendered at all** |

### Relationship attributes likely NOT surfaced

| Relationship | Likely attribute on edge | Impact |
|-------------|------------------------|--------|
| `DELIVERS_VIA` | `lesson_allocation` (which lessons teach which concept) | Can't build lesson plans |
| `DELIVERS_VIA` | `is_primary` (boolean) | Surfaced implicitly but secondaries get truncated treatment |
| `HAS_VOCABULARY` | `tier` (core/supporting/extended) | Vocabulary is unbucketed |
| `HAS_VOCABULARY` | `concept_source` (which concept introduced this term) | Can't assign vocab to lessons |
| `HAS_SKILL` | `lesson_allocation` | Can't assign skills to lessons |
| `HAS_SKILL` | `assessment_weight` | Can't prioritise skill assessment |
| `FOLLOWS` | `shared_concepts` | Can't build on prior study |
| `FOLLOWS` | `comparison_dimensions` | Can't structure the comparison |

---

## Part 3: Priority Surfacing Fixes

Ranked by impact — what would most improve the output without adding any new content to the model.

### Critical (would transform the output)

| # | Fix | What to surface | Why it matters |
|---|-----|----------------|----------------|
| 1 | **Surface the YearGroup node** | Year, teaching guidance, pupil profile, expectations | Addresses tone, scaffolding, calibration. User confirmed this data exists. |
| 2 | **Expand secondary concepts fully** | Full description, teaching guidance, misconceptions, differentiation, model responses for C001-C005 | 5 concepts worth of rich data is being truncated to ~15 words each |
| 3 | **Surface vocabulary definitions** | Definitions for all terms in the word mat | 85+ terms with empty meaning columns when definitions likely exist |
| 4 | **Expand Place Study session structure phases** | Phase descriptions, objectives, durations, pupil outputs, assessment focus | Would directly create the lesson-level breakdown that's missing |
| 5 | **Expand exemplar region nodes** | Physical features, human features, climate, key facts, comparison points per exemplar | Would let teachers make an informed region choice with real data |

### High (would significantly improve usability)

| # | Fix | What to surface |
|---|-----|----------------|
| 6 | Expand prior knowledge descriptions | Full descriptions (currently truncated with "...") |
| 7 | Surface sequencing relationship attributes | Preceding study region, comparison framework, knowledge to carry forward |
| 8 | Surface secondary thinking lens stems | Question stems for Evidence and Argument lens |
| 9 | Surface skill-to-concept mappings | Which skills apply to which concepts/lessons |
| 10 | Surface cross-curricular link details | Target study ID, suggested timing, shared vocabulary |

### Medium (would add polish)

| # | Fix | What to surface |
|---|-----|----------------|
| 11 | Surface difficulty level teacher prompts | "What to say to move pupils up" per level |
| 12 | Surface vocabulary tier/concept links | Which terms are core vs supporting, which concept owns each |
| 13 | Surface KS2 assessment framework | Working towards / expected / greater depth formal criteria |
| 14 | Surface prior knowledge retrieval questions | Ready-made retrieval starters |
| 15 | Surface skill assessment indicators | How to know if a skill is demonstrated |

---

## Part 4: Summary

### What the export DOES surface well
- GeoStudy identity and curriculum anchor (excellent)
- Primary concept in full depth (excellent)
- Differentiation with model responses (excellent)
- Pitfalls and sensitivity guidance (excellent)
- Thinking lens with rationale (good)
- Success criteria (good)
- Prior knowledge structure (good, but truncated)

### What the export FAILS to surface from the model

| Category | Estimated data loss | Severity |
|----------|-------------------|----------|
| YearGroup node (entire node not queried) | 100% lost | **Critical** |
| Secondary concept detail (5 concepts truncated) | ~90% lost | **Critical** |
| Vocabulary definitions | 100% lost | **Critical** |
| Session structure phase detail | ~80% lost | **Critical** |
| Exemplar region node detail | ~90% lost | **High** |
| Prior knowledge descriptions | ~70% lost (truncation) | **High** |
| Sequencing relationship attributes | ~80% lost | **High** |
| Skill node attributes beyond name/description | ~60% lost | **Medium** |
| Cross-curricular link detail | ~50% lost | **Medium** |
| Difficulty level scaffolding attributes | ~70% lost | **Medium** |
| Secondary thinking lens detail | ~50% lost | **Low** |

### The verdict

**Before adding any new content to the model, at least 5 critical surfacing fixes should be made.** The model appears to contain substantially more data than the export renders. The year group node alone — which the user confirmed exists — would address multiple feedback points (tone, scaffolding expectations, pupil profile, age-appropriate calibration).

The pattern is consistent: the prompt/template favours the primary concept and the study-level metadata, but truncates or ignores secondary concepts, child nodes of the session structure, the year group context, and vocabulary definitions. Fixing the template to fully traverse these nodes would produce a dramatically richer output from the same underlying data.

**Estimated improvement from surfacing alone (no new content): 40-60% of the feedback could be addressed.**

---

*This audit should be verified against the actual graph schema. Some "likely attributes" may not exist — but the structural evidence (truncation patterns, empty columns, confirmed year group data) strongly suggests the model holds far more than the export shows.*
