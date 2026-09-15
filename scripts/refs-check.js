#!/usr/bin/env node
/**
 * refs-check.js - Check referenced files in SKILL.md files exist (read-only)
 *
 * Checks:
 *   - archive-learning/scripts/ocr.ps1
 *   - report-board/templates/control-board-template.html
 *   - delivery-review/scripts/scan-sensitive.sh
 *
 * Returns { pass: boolean, issues: [] } for use by validate-contract.js
 */
'use strict';
const path = require('path');
const fs = require('fs');

function runSkillsCheck() {
  const filesToCheck = [
    path.join(__dirname, '..', '.claude', 'skills', 'archive-learning', 'scripts', 'ocr.ps1'),
    path.join(__dirname, '..', '.claude', 'skills', 'report-board', 'templates', 'control-board-template.html'),
    path.join(__dirname, '..', '.claude', 'skills', 'delivery-review', 'scripts', 'scan-sensitive.sh')
  ];

  const issues = [];
  let allExist = true;

  filesToCheck.forEach(file => {
    if (fs.existsSync(file)) {
      // OK
    } else {
      issues.push({ file: path.relative(__dirname + '/../..', file), msg: 'Referenced file does not exist', level: 'warn' });
      allExist = false;
    }
  });

  return { pass: allExist, issues };
}

// Allow direct execution for testing
if (require.main === module) {
  const result = runSkillsCheck();
  console.log('');
  console.log('==============================');
  console.log(' AI-WAREHOUSE Contract Validation');
  console.log('==============================');
  console.log('[SKILLS] reference integrity');

  if (result.pass) {
    console.log('  [OK] All referenced files exist');
  } else {
    result.issues.forEach(issue => {
      console.log(`  [WARN] ${issue.file} - ${issue.msg}`);
    });
  }

  console.log('');
  console.log('==============================');
  console.log(`PASS: ${result.pass ? 1 : 0}  WARN: ${result.issues.length}  FAIL: 0`);
  console.log('==============================');

  process.exit(result.pass ? 0 : 1);
}

module.exports = {
  runSkillsCheck
};