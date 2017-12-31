$(function () {
  if ($('[id^="topic-"]').length) {
    App.cable.subscriptions.create({
      channel: 'TopicChannel',
      topic: $('[id^="topic-"]').attr('id').replace('topic-', ''),
    }, {
      received(data) {
        this.appendLine(data)
        $('textarea').val('')
      },
      appendLine(data) {
        var html = this.createLine(data)
        $('.post-list').append(html)
      },
      createLine(data) {
        return `
          <li>
            <div class="row">
              <div class="col-md-1"></div>
              <div class="col-md-6">
              <p>
                ${data['author']['username']}
              </p>
              </div>
              <div class="col-md-5 text-right">
                <date>
                  ${data['created_at']}
                </date>
              </div>
            </div>

            <div class="row">
              <div class="col-md-6 col-md-offset-1">
                ${data['content']}
              </div>
            </div>
          </li>
        `
      }
    })
  }
})
