jQuery(document).on 'page:change', ->
  if jQuery('.page-answers-index').length
    new AnswerPage jQuery('.page-answers-index')

class AnswerPage
  constructor: (@$elm)->
    @bind_events()

  delete_blank: (str)->
    str.replace(/(^\s+)|(\s+$)/g,"")

  reback_answer_content: (dom,update_content)->
    jQuery('.textarea').closest('td').after(dom);
    jQuery('.textarea').closest('td').closest('.col-md-10').find('.content').text(update_content)
    jQuery('.textarea').closest('td').remove();

  bind_events: ->
    @$elm.on 'click','.answer-update',(evt)=>
      answer_content = jQuery(event.target).closest('.answer-content').find('.content').text()
      content_text_area = "<td>"+
        "<input type='text' name='textfield' class='textarea' value=" + answer_content + ">" +
        "<button class='submit'> 提交 </span>"+
        "<button class='cancel'>取消</span>"+
        "</td>"

      dom = jQuery(event.target).closest('.answer-content').clone()
      jQuery(event.target).closest('.answer-content').before(content_text_area)
      answer_id = jQuery(event.target).closest('.answer-content').find('.answer-id').text()
      jQuery(event.target).closest('.answer-content').remove()

      @$elm.on 'click','.cancel',(evt)=>
        jQuery(event.target).closest('td').after(dom)
        jQuery(event.target).closest('td').remove()

      @$elm.on 'click','.submit',(evt)=>
        a = @delete_blank(answer_id)
        update_content = jQuery(event.target).closest('td').find('.textarea').val()
        url = 'answers/' + a
        jQuery.ajax
          url: url,
          type: 'PATCH',
          data: {
            'answer[content]': update_content,
          },
          success: @reback_answer_content(dom,update_content)
