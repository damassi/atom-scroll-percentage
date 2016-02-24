module.exports = ScrollPercentage =

  activate: (state) ->

  deactivate: ->
    @statusBarTile?.destroy()
    @statusBarTile = null

  consumeStatusBar: (statusBar) ->
    scrollLabel = document.createElement 'span'
    scrollLabel.className = 'scroll-percentage';
    scrollLabel.textContent = @formatLabel 0

    @statusBarTile = statusBar.addRightTile
      item: scrollLabel
      priority: 100

    atom.workspace.observeActivePaneItem (item) =>
      editor = atom.workspace.getActiveTextEditor()

      if editor
        editor.onDidChangeScrollTop (scrollTop) =>
          scrollHeight = editor.getScrollHeight()
          totalHeight  = editor.getHeight()
          pct = 0

          if scrollHeight != totalHeight
            pct = Math.round scrollTop / (scrollHeight - totalHeight) * 100

          scrollLabel.textContent = @formatLabel pct

  formatLabel: (pct) ->
    pct + '%'
