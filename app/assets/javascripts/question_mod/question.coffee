jQuery(document).on 'page:change', ->
  if jQuery('.page-answers-index').length
    new AnswerPage jQuery('.page-answers-index')
  if jQuery('.page-questions-index').length
    new QuestionPage jQuery('.page-questions-index')

class Function
  delete_blank: (str)->
    str.replace(/(^\s+)|(\s+$)/g,"");

  content_text_area: (answer_content)->
    content_text_area = "<div>"+
        "<input type='text' name='textfield' class='textarea' value=" + answer_content + ">" +
        "<button class='submit'> 提交 </span>"+
        "<button class='cancel'>取消</span>"+
        "</div>"

  hide_comment: ->
    hide_comment = "<a class='hide-comment'>收起评论</a>"

  add_buttons: ->
    add_buttons = "<div>" +
        "<span class='cancel'>取消</span>"+
        "<button class='submit'>评论</span>"+
        "</div>"

  jQuery_ajax: (uri,request_type,contents,success_fuction)->
    jQuery.ajax
      url: uri,
      type: request_type,
      data: {
        'answer[content]': contents,
      },
      success: success_fuction

  new_comment: (content,current_user)->
    new_comment = "<tr>" +
      "<td>" +
      "<div>" + current_user + "</div>" +
      "<div>" + content + "</div>" +
      "</td>" +
      "</tr>"

  view_new_comment: (content,current_user)->
    new_comment = @new_comment(content,current_user)
    jQuery(event.target).closest('.question-each').find('.question-comment-table').find('tr').last().after(new_comment)

  question_comment_view: ()->
    jQuery(event.target).closest('.question-each').find('.question-comment-table').removeClass('hidden')
    jQuery(event.target).closest('.question-each').find('.add-question-comment').removeClass('hidden')
    hide_comment_dom = @hide_comment()
    jQuery(event.target).after(hide_comment_dom)
    jQuery(event.target).addClass('hidden')
    @$elm.on 'click','.hide-comment',(evt)=>
      jQuery(event.target).closest('.question-each').find('.question-comment-table').addClass('hidden')
      jQuery(event.target).closest('.question-each').find('.add-question-comment').addClass('hidden')
      jQuery(event.target).closest('.question-each').find('.question-comment-count').removeClass('hidden')
      jQuery(event.target).remove()
  
  answer_comment_view: ()->
    jQuery(event.target).closest('.answer-each').find('.answer-comment-table').removeClass('hidden')
    jQuery(event.target).closest('.answer-each').find('.add-answer-comment').removeClass('hidden')
    hide_comment_dom = @hide_comment()
    jQuery(event.target).after(hide_comment_dom)
    jQuery(event.target).addClass('hidden')
    @$elm.on 'click','.hide-comment',(evt)=>
      jQuery(event.target).closest('.answer-each').find('.answer-comment-table').addClass('hidden')
      jQuery(event.target).closest('.answer-each').find('.add-answer-comment').addClass('hidden')
      jQuery(event.target).closest('.answer-each').find('.answer-comment-count').removeClass('hidden')
      jQuery(event.target).remove()


class AnswerPage extends Function
  constructor: (@$elm)->
    @bind_events()

  reback_answer_content: (dom,update_content)->
    jQuery('.textarea').closest('div').after(dom);
    jQuery('.answer-update').closest('.answer-content').find('.content').text(update_content)
    jQuery('.textarea').closest('div').remove();

  bind_events: ->
    @$elm.on 'click','.answer-update',(evt)=>
      str = jQuery(event.target).closest('.answer-content').find('.content').text()
      answer_content = @delete_blank(str)
      content_text_area = @content_text_area(answer_content)
      dom = jQuery(event.target).closest('.answer-content').clone()
      jQuery(event.target).closest('.answer-content').before(content_text_area)
      answer_id = jQuery(event.target).closest('.answer-content').find('.answer-id').text()
      jQuery(event.target).closest('.answer-content').remove()

      @$elm.on 'click','.cancel',(evt)=>
        jQuery(event.target).closest('div').after(dom)
        jQuery(event.target).closest('div').remove()

      @$elm.on 'click','.submit',(evt)=>
        id = @delete_blank(answer_id)
        update_content = jQuery(event.target).closest('div').find('.textarea').val()
        url = 'answers/' + id
        @jQuery_ajax(url,'PATCH',update_content,@reback_answer_content(dom,update_content))

    @$elm.on 'click','.question-comment-count',(evt)=>
      @question_comment_view()

    @$elm.on 'click','.question-comment-content-area',(evt)=>
      question_id = jQuery(event.target).closest('.add-question-comment').find('.question-id').text()
      dom = @add_buttons()
      jQuery(event.target).after(dom)

      @$elm.on 'click','.cancel',(evt)=>
        jQuery(event.target).closest('div').remove()

      @$elm.on 'click','.submit',(evt)=>
        current_user = @delete_blank(jQuery(event.target).closest('.question-each').find('.current-user').text())
        jQuery(event.target).closest('div').remove()
        id = @delete_blank(question_id)
        content = jQuery(event.target).closest('div').find('.question-comment-content-area').val()
        url = "questions/#{id}/question_comments"
        @jQuery.ajax(url,'POST',content,@view_new_comment(content,current_user))

    @$elm.on 'click','.answer-comment-count',(evt)=>
      @answer_comment_view()


    @$elm.on 'click','.answer-comment-content-area',(evt)=>
      answer_id = jQuery(event.target).closest('.add-answer-comment').find('.answer-id').text()
      dom = @add_buttons()
      jQuery(event.target).after(dom)

      @$elm.on 'click','.cancel',(evt)=>
        jQuery(event.target).closest('div').remove()

      @$elm.on 'click','.submit',(evt)=>
        current_user = @delete_blank(jQuery(event.target).closest('.answer-each').find('.current-user').text())
        jQuery(event.target).closest('div').remove()
        answer_id = @delete_blank(answer_id)
        content = jQuery(event.target).closest('div').find('.answer-comment-content-area').val()
        url = "answers/#{answer_id}/answer_comments"
        @jQuery.ajax(url,'POST',content,@view_new_comment(content,current_user))


class QuestionPage extends Function
  constructor: (@$elm)->
    @bind_events()

  bind_events: ->
    @$elm.on 'click','.question-comment-count',(evt)=>
      @question_comment_view()

    @$elm.on 'click','.question-comment-content-area',(evt)=>
      question_id = jQuery(event.target).closest('.add-question-comment').find('.question-id').text()
      dom = @add_buttons()
      jQuery(event.target).after(dom)

      @$elm.on 'click','.cancel',(evt)=>
        jQuery(event.target).closest('div').remove()

      @$elm.on 'click','.submit',(evt)=>
        current_user = @delete_blank(jQuery(event.target).closest('.question-each').find('.current-user').text())
        content = jQuery(event.target).closest('.add-question-comment').find('.question-comment-content-area').val()
        jQuery(event.target).closest('div').remove()
        id = @delete_blank(question_id)
        url = "/questions/#{id}/question_comments"
        @jQuery_ajax(url,'POST',content,@view_new_comment(content,current_user))





