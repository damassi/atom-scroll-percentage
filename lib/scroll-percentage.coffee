module.exports = ScrollPercentage =

  activate: (state) ->

  deactivate: ->
    @statusBarTile?.destroy()
    @statusBarTile = null

  consumeStatusBar: (statusBar) ->
    scrollLabel = document.createElement 'span'
    scrollLabel.id = 'scroll-percentage';
    scrollLabel.textContent = @formatLabel 0

    @statusBarTile = statusBar.addLeftTile
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

            if pct > 100 then pct = 100
            if pct < 0   then pct = 0

          scrollLabel.textContent = @formatLabel pct

  formatLabel: (pct) ->
    pct + '%'
