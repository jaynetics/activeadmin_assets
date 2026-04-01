import { execSync } from 'child_process'
import activeAdminPlugin from '@activeadmin/activeadmin/plugin'

// Always use the last line of output since Bundler's DEBUG env will print additional lines.
const activeAdminPath = execSync('bundle show activeadmin', { encoding: 'utf-8' }).trim().split(/\r?\n/).pop();

export default {
  content: [
    `${activeAdminPath}/vendor/javascript/flowbite.js`,
    `${activeAdminPath}/plugin.js`,
    `${activeAdminPath}/app/views/**/*.{arb,erb,html,rb}`,
  ],
  darkMode: "selector",
  plugins: [
    activeAdminPlugin
  ]
}
