{$,View} = require 'atom'
parser = require './build-parser.coffee'

module.exports =
class BuildToolsCommandOutput extends View
  @content: ->
    @div class:'build-tools-cpp', =>
      @div class:"commandheader horizontal", =>
        @div class:"btn-container pull-left", style:"width:70px;height:150px;", =>
          @div class: '', =>
            @input id:"mesh_build" , type:"button", value:"BUILD" , class: 'btn btn-default mesh-tool-btn'
          @div class: '', =>
            @input id:"mesh_clean" , type:"button", value:"CLEAN" , class: 'btn btn-default mesh-tool-btn'
          @div class: '', =>
            @input id:"mesh_list"  , type:"button", value:"LIST"  , class: 'btn btn-default mesh-tool-btn'
          @div class: '', =>
            @input id:"mesh_upload", type:"button", value:"UPLOAD", class: 'btn btn-default mesh-tool-btn'
        @div class:"commandoutput", outlet:"cmd_output"
        @div class:"commandname panel-body", style:"height:20px;"

  initialize: ->
    $(document).on 'click','.commandclose', =>
      @hideBox()
    $(document).on "click", '#mesh_build', =>
      atom.packages.getActivePackage('build-tools-cpp').mainModule.doBuild()
    $(document).on "click", '#mesh_clean', =>
      atom.packages.getActivePackage('build-tools-cpp').mainModule.doClean()
    $(document).on "click", '#mesh_list', =>
      atom.packages.getActivePackage('build-tools-cpp').mainModule.doList()
    $(document).on "click", '#mesh_upload', =>
      atom.packages.getActivePackage('build-tools-cpp').mainModule.doFlash()
    @showBox()
    return

  serialize: ->

  destroy: ->
    @detach()

  attach: ->
    atom.workspaceView.appendToBottom(this)

  show: ->
    @showBox() if !@visible
    @showHeaderLineOnly()

  hide: ->
    @hideBox() if @visible

  hideBox: ->
    @detach()
    @visible = false

  showBox: ->
    @attach()
    @visible = true

  showHeaderLineOnly: ->
    #$(document).find(".commandoutput").addClass("build-tools-cpp-hidden")

  showOutput: ->
    #$(document).find(".commandoutput").removeClass("build-tools-cpp-hidden")

  toggleBox: ->
    if @visible
      @hideBox()
    else
      @showBox()

  clear: ->
    $(document).find(".commandoutput").text('')
    parser.clearVars()

  outputLineParsed: (line,script) =>
    line = line.toString()
    parser.toLine line, script, @printLine

  openFile: (element) ->
    lineno = parseInt($(this).attr('row'))
    linecol= parseInt($(this).attr('col'))
    if $(this).attr('name') isnt ''
      atom.workspaceView.open($(this).attr('name')).then (editor) ->
        if lineno isnt 0
          editor.setCursorBufferPosition([lineno-1,linecol-1])

  finishConsole: ->
    parser.poplines(@printLine)
    $(document).find(".filelink").on 'click', @openFile

  printLine: (message) =>
    @showOutput() if !@lockoutput
    @cmd_output.append(message)
    @cmd_output.scrollTop(@cmd_output[0].scrollHeight)

  setHeader: (name) ->
    $(document).find(".commandname").html("<b>#{name}</b>")

  setHeaderOnly: (text) ->
    @showHeaderLineOnly()
    $(document).find(".commandname").html("<b>#{text}</b>")

  lock: ->
    @lockoutput = true

  unlock: ->
    @lockoutput = false

  visible: true
  lockoutput: false
