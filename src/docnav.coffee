# docnav.coffee
#
# Create a DocPad directory structure based off of a yaml navigation
#
####################################################################

fs = require('fs')
yml = require('js-yaml')

argv = require('optimist')
  .usage('Create a DocPad directory structure based off of a yaml navigation')
  .demand('d')
  .describe('d','/src/documents directory')
  .demand('n')
  .describe('n', 'Location of Nav File')
  .argv

src = argv.d
nav = argv.n

# For reading the nav
getFileAsString = (filePath)->
  fs = require "fs"
  fs.readFileSync filePath, "utf-8"

# Title helper
titleCase = (x)->
  x = x.replace(/-/g,' ')
  x.replace(/\w\S*/g, 
    (txt)-> 
      txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
  )

# Write index.html for each nav directory.
# Can alter the metadata to whatever we need
writeIndex = (cwd,title)->
  meta =  """
          ---
          layout: 'default'
          title: '#{title}'
          nav_title: '#{title}'
          ---
          """

  fs.writeFile cwd+'/index.html', meta

# Create the directory for the nav item, then iterate through its children, if it has any
iterator = (item,cwd)->
  if typeof item is 'object' # If we have kids
    for key, i of item
      fs.mkdir cwd + '/' + key
      cwd = cwd + '/' + key
      title = titleCase key
      
      writeIndex cwd,title

      for x in i
        iterator x, cwd

  else if typeof item is 'string' # If we don't have kids 
    fs.mkdir cwd + '/' + item
    cwd = cwd + '/' + item
    title = titleCase item

    writeIndex cwd,title

# Get the nav file and look for 'main'
x = yml.load getFileAsString nav
x = x['main']

# Iterate through the nav file
for key, item of x
  iterator x[key], src