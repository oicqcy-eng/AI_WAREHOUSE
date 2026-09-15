#!/usr/bin/env node
/**
 * validate-contract.js - V1r2 Contract Validator
 *
 * Four dimensions:
 *   1. Data Schema (worklog-schema.js)
 *   2. Tool Contract (worklog-append.js validate --json)
 *   3. Knowledge Index (knowledge-index.json structure)
 *   4. Skills Reference (refs-check.js)
 *
 * Usage:
 *   node validate-contract.js              # full check
 *   node validate-contract.js --phase schema
 *   node validate-contract.js --phase tools
 *   node validate-contract.js --phase knowledge
 *   node validate-contract.js --phase skills
 *   node validate-contract.js --json       # JSON output
 */
'use strict';

// Parse args
const args = process.argv.slice(2);
let phase = null;
let jsonOutput = false;

args.forEach(arg => {
  if (arg === '--json') jsonOutput = true;
  else if (arg.startsWith('--phase')) {
    phase = arg.split('=')[1] || args[args.indexOf(arg) + 1];
  } else if (['schema', 'tools', 'knowledge', 'skills'].includes(arg)) {
    phase = arg;
  }
});

const results = {};
const phases = phase ? [phase] : ['schema', 'tools', 'knowledge', 'skills'];

// Phase 1: Data Schema
if (phases.includes('schema')) {
  const { runSchemaCheck } = require('./check-worklog-schema');
  results.schema = runSchemaCheck();
}

// Phase 2: Tool Contract
if (phases.includes('tools')) {
  const { runToolContractCheck } = require('./check-tool-contracts');
  results.tools = runToolContractCheck();
}

// Phase 3: Knowledge Index
if (phases.includes('knowledge')) {
  const { runKnowledgeCheck } = require('./knowledge-index-check');
  results.knowledge = runKnowledgeCheck();
}

// Phase 4: Skills Reference
if (phases.includes('skills')) {
  const { runSkillsCheck } = require('./refs-check');
  results.skills = runSkillsCheck();
}

// Output
if (jsonOutput) {
  console.log(JSON.stringify(results, null, 2));
} else {
  printTextReport(results);
}

function printTextReport(results) {
  console.log('');
  console.log('==============================');
  console.log(' AI-WAREHOUSE Contract Validation');
  console.log('==============================');

  let totalPass = 0, totalWarn = 0, totalFail = 0;

  // Schema
  console.log('\n[DATA] worklog-schema.js');
  const schemaIssues = results.schema?.issues || [];
  const schemaPass = 2 - schemaIssues.filter(i => i.level === 'error').length;
  console.log(`  [OK] ENUM consistency: ${schemaPass >= 0 ? 'PASS' : 'FAIL'}`);
  totalPass += Math.max(0, schemaPass);
  totalWarn += schemaIssues.filter(i => i.level === 'warn').length;
  totalFail += schemaIssues.filter(i => i.level === 'error').length;

  schemaIssues.forEach(issue => {
    const icon = issue.level === 'warn' ? '[WARN]' : '[FAIL]';
    console.log(`  ${icon} ${issue.field}: ${issue.msg}`);
  });

  // Tools
  console.log('\n[TOOLS] worklog-append.js');
  if (results.tools?.pass) {
    console.log('  [OK] validate subcommand runs and returns JSON');
    totalPass++;
  } else {
    console.log(`  [FAIL] ${results.tools?.error || 'Unknown error'}`);
    totalFail++;
  }

  // Knowledge
  console.log('\n[KNOWLEDGE] knowledge-index.json');
  const kIssues = results.knowledge?.issues || [];
  const kPass = 3 - kIssues.filter(i => i.level === 'error').length;
  console.log(`  [OK] Structure valid: ${kPass}/3 checks passed`);
  totalPass += Math.max(0, kPass);
  totalWarn += kIssues.filter(i => i.level === 'warn').length;
  totalFail += kIssues.filter(i => i.level === 'error').length;

  kIssues.forEach(issue => {
    const icon = issue.level === 'warn' ? '[WARN]' : '[FAIL]';
    console.log(`  ${icon} ${issue.field}: ${issue.msg}`);
  });

  // Skills
  console.log('\n[SKILLS] reference integrity');
  if (results.skills?.pass) {
    console.log('  [OK] All referenced files exist');
    totalPass++;
  } else if (results.skills?.issues) {
    console.log('  [WARN] Some referenced files missing');
    totalWarn += results.skills.issues.length;
  }

  console.log('');
  console.log('==============================');
  console.log(`PASS: ${totalPass}  WARN: ${totalWarn}  FAIL: ${totalFail}`);
  console.log('==============================');

  process.exit(totalFail > 0 ? 1 : 0);
}