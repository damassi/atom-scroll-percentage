module.exports = ScrollPercentage =

  activate: (state) ->

  deactivate: ->
    @statusBarTile?.destroy()
    @statusBarTile = null

  consumeStatusBar: (statusBar) ->
    pct = 100

    scrollLabel = document.createElement 'span'
    scrollLabel.id = 'scroll-percentage';
    scrollLabel.textContent = @formatLabel pct

    @statusBarTile = statusBar.addLeftTile
      item: scrollLabel
      priority: 100

    atom.workspace.observeActivePaneItem (item) =>
      editor = atom.workspace.getActiveTextEditor()

      if editor

        editor.onDidChangeScrollTop (scrollTop) =>
          scrollHeight = editor.getScrollHeight()
          viewportHeight  = editor.getHeight()

          if scrollHeight != viewportHeight
            pct = Math.round scrollTop / (scrollHeight - viewportHeight) * 100

            if isNaN(pct) then pct = 100
            if pct > 100  then pct = 100
            if pct < 0    then pct = 0

          scrollLabel.textContent = @formatLabel pct

  formatLabel: (pct) ->
    pct + '%'
