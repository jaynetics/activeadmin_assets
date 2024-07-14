const execSync = require('child_process').execSync
const activeAdminPath = execSync('bundle show activeadmin', { encoding: 'utf-8' }).trim()

module.exports = {
  content: [
    `${activeAdminPath}/vendor/javascript/flowbite.js`,
    `${activeAdminPath}/plugin.js`,
    `${activeAdminPath}/app/views/**/*.{arb,erb,html,rb}`,
  ],
  darkMode: "class",
  plugins: [
    require(`${activeAdminPath}/plugin.js`)
  ]
}
