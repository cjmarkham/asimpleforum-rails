$(function () {
  var triggerMap = {
    bold: {
      start: '<strong>',
      end: '</strong>',
    },
    italic: {
      start: '<em>',
      end: '</em>',
    },
    underline: {
      start: '<u>',
      end: '</u>',
    },
    image: {
      isFunction: true,
      func: insertImage,
    }
  }

  var textarea = $('.editor textarea');

  textarea.on('change input', function (e) {
    var preview = $('.editor .preview')
    preview.html(textarea.val().replace(/\n/g, '<br />'))
  });

  $('.editor .editor-triggers li a').on('click', function (e) {
    e.preventDefault()
    var trigger = $(e.currentTarget)

    var triggerType = trigger.attr('data-trigger')
    var mappedTrigger = triggerMap[triggerType]
    if ( ! mappedTrigger) {
      return
    }

    if (mappedTrigger.isFunction) {
      mappedTrigger.func()
    } else {
      var start = mappedTrigger.start
      var end = mappedTrigger.end
      insertText(start, end)
    }
  })
})

var insertText = function (start, end = '') {
  var textarea = $('.editor textarea')
  var cursorPosition = textarea.prop('selectionStart')
  var node = textarea[0]

  var selection = window.getSelection().toString()
  var originalValue = textarea.val()
  var textBefore = originalValue.substring(0, cursorPosition)
  var textAfter = originalValue.substring(cursorPosition + selection.length, originalValue.length)

  if (selection) {
    textarea.val(textBefore + start + selection + end + textAfter)
  } else {
    textarea.val(textBefore + start + end + textAfter)

    if (node.setSelectionRange) {
      node.setSelectionRange(textBefore.length + start.length, textBefore.length + start.length)
      textarea.focus()
    } else if (node.createTextRange) {
      var range = node.createTextRange()
      range.collapse(true);
      range.moveEnd('character', textBefore.length + start.length)
      range.moveStart('character', textBefore.length + start.length)
    }
  }

  textarea.trigger('change')
}

var insertImage = function (e) {
  var input = $('.editor input[name="image-upload"]')
  input.trigger('click')

  input.on('change', function (e) {
    var file = input[0].files[0]
    var formData = new FormData()
    formData.append("image[file]", file)

    var request = new XMLHttpRequest();
    request.open('POST', '/images');
    request.send(formData)
    request.onload = function (response) {
      if (request.status.toString() === '201') {
        var imageData = JSON.parse(request.response)

        insertText('<img src="' + imageData.file.url + '" />')

        var imageIdsElement = $('.editor input[name="post[image-ids]"]')
        var imageIds = imageIdsElement.val()
        if ( ! imageIds) {
          imageIds = []
        } else {
          imageIds = imageIds.split(',')
        }

        imageIds.push(imageData.id)
        imageIdsElement.val(imageIds.join(','))
      } else {
        console.error(request.status, request)
      }
    }

    input.off('change')
  })
}
