module.exports = ScrollPercentage =

  activate: (state) ->

  deactivate: ->
    @statusBarTile?.destroy()
    @statusBarTile = null

  consumeStatusBar: (statusBar) ->
    scrollLabel = document.createElement 'span'
    scrollLabel.textContent = '0%'
    scrollLabel.className = 'scroll-percentage';

    @statusBarTile = statusBar.addRightTile
      item: scrollLabel
      priority: 100

    atom.workspace.observeActivePaneItem (item) =>
      editor = atom.workspace.getActiveTextEditor()

      if editor
        editor.onDidChangeScrollTop (scrollTop) ->
          scrollHeight = editor.getScrollHeight()
          totalHeight  = editor.getHeight()
          pct = Math.round(scrollTop / (scrollHeight - totalHeight) * 100)

          scrollLabel.textContent = pct + '%'

















































































































# hi
