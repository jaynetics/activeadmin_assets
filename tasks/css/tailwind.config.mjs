import { execSync } from 'child_process'
import activeAdminPlugin from '@activeadmin/activeadmin/plugin'

const activeAdminPath = execSync('bundle show activeadmin', { encoding: 'utf-8' }).trim()

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
