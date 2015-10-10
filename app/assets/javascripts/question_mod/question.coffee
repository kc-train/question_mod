jQuery(document).on 'page:change', ->
  if jQuery('.page-answers-index').length
    new AnswerPage jQuery('.page-answers-index')
  if jQuery('.page-questions-index').length
    new QuestionPage jQuery('.page-questions-index')

class Function
  delete_blank: (str)->
    str.replace(/(^\s+)|(\s+$)/g,"");

  content_text_area: (classname,answer_content)->
    content_text_area = "<div class=" + classname + ">"+
        "<input type='text' name='textfield' class='textarea' value=" + answer_content + ">" +
        "<button class='submit btn btn-defualt'> 提交 </span>"+
        "<button class='cancel btn btn-defualt'>取消</span>"+
        "</div>"

  hide_comment: ->
    hide_comment = "<a class='hide-comment'>收起评论</a>"

  add_buttons: (classname)->
    dom = "<div class=" + classname + ">" +
        "<span class='cancel'>取消</span>"+
        "<button class='submit  btn btn-defualt'>评论</span>"+
        "</div>"
    jQuery(event.target).after(dom)

  add_input_and_buttons: (classname)->
    content_text_area = @content_text_area(classname,"")
    jQuery(event.target).closest('td').append(content_text_area)

  question_jQuery_ajax: (uri,request_type,contents,success_fuction)->
    jQuery.ajax
      url: uri,
      type: request_type,
      data: {
        'question[content]': contents,
      },
      success: success_fuction

  answer_jQuery_ajax: (uri,request_type,contents,success_fuction)->
    jQuery.ajax
      url: uri,
      type: request_type,
      data: {
        'answer[content]': contents,
      },
      success: success_fuction

  question_comment_jQuery_ajax: (uri,request_type,contents,success_fuction)->
    jQuery.ajax
      url: uri,
      type: request_type,
      data: {
        'question_comment[content]': contents,
      },
      success: success_fuction

  comment_question_comment_jQuery_ajax: (uri,request_type,contents,id,success_fuction)->
    jQuery.ajax
      url: uri,
      type: request_type,
      data: {
        'question_comment[content]': contents,
        'question_comment[question_comment_id]': id,
      },
      success: success_fuction

  answer_comment_jQuery_ajax: (uri,request_type,contents,success_fuction)->
    jQuery.ajax
      url: uri,
      type: request_type,
      data: {
        'answer_comment[content]': contents,
      },
      success: success_fuction

  comment_answer_comment_jQuery_ajax: (uri,request_type,contents,id,success_fuction)->
    jQuery.ajax
      url: uri,
      type: request_type,
      data: {
        'answer_comment[content]': contents,
        'answer_comment[answer_comment_id]': id,
      },
      success: success_fuction

  delete_comment: ()->
    jQuery(event.target).closest('td').remove()

  delete_input_and_buttons: ()->
    jQuery(event.target).closest('div').remove()

  delete_jQuery_ajax: (uri)->
    jQuery.ajax
      url: uri,
      type: 'DELETE',
      success: @delete_comment()

  new_comment: (content,current_user)->
    new_comment = "<tr>" +
      "<td>" +
      "<div>" + current_user + "</div>" +
      "<div>" + content + "</div>" +
      "</td>" +
      "</tr>"

  view_new_question_comment: (content,current_user)->
    new_comment = @new_comment(content,current_user)
    jQuery(event.target).closest('.question-each').find('.question-comment-table').find('.table-striped').append(new_comment)
    @delete_input_and_buttons()

  view_new_answer_comment: (content,current_user)->
    new_comment = @new_comment(content,current_user)
    jQuery(event.target).closest('.answer-each').find('.answer-comment-table').find('.table-striped').append(new_comment)
    @delete_input_and_buttons()

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

  get_answer_id: ()->
    answer_id = @delete_blank(jQuery(event.target).closest('.answer-each').find('.add-answer-comment').find('.answer-id').text())

  get_question_id: ()->
    question_id = @delete_blank(jQuery(event.target).closest('.question-each').find('.add-question-comment').find('.question-id').text())

  get_question_comment_id: ()->
    question_comment_id = @delete_blank(jQuery(event.target).closest('td').find('.question-comment-id').text())

  get_answer_comment_id: ()->
    answer_comment_id = @delete_blank(jQuery(event.target).closest('td').find('.answer-comment-id').text())

  comment_get_input_value: ()->
    content = jQuery(event.target).closest('div').find('.textarea').val()

  question_get_input_value: ()->
    content = jQuery(event.target).closest('.add-question-comment').find('.question-comment-content-area').val()

  answer_get_input_value: ()->
    content = jQuery(event.target).closest('.add-answer-comment').find('.answer-comment-content-area').val()

  question_get_current_user: ()->
    current_user = @delete_blank(jQuery(event.target).closest('.question-each').find('.current-user').text())

  answer_get_current_user: ()->
    current_user = @delete_blank(jQuery(event.target).closest('.answer-each').find('.current-user').text())

class AnswerPage extends Function
  constructor: (@$elm)->
    @bind_events()

  reback_answer_content: (dom,update_content)->
    jQuery('.textarea').closest('div').after(dom);
    jQuery('.answer-update').closest('.answer-content').find('.content').text(update_content)
    jQuery('.textarea').closest('div').remove();

  bind_events: ->
    @$elm.on 'click', '.answer-update', (evt)=>
      str = jQuery(event.target).closest('.answer-content').find('.content').text()
      answer_content = @delete_blank(str)
      classname = "answer-update-buttons"
      content_text_area = @content_text_area(classname,answer_content)
      dom = jQuery(event.target).closest('.answer-content').clone()
      jQuery(event.target).closest('.answer-content').before(content_text_area)
      answer_id = jQuery(event.target).closest('.answer-content').find('.answer-id').text()
      jQuery(event.target).closest('.answer-content').remove()

      @$elm.on 'click', '.answer-update-buttons .cancel', (evt)=>
        jQuery(event.target).closest('div').after(dom)
        @delete_input_and_buttons()

      @$elm.on 'click','.answer-update .submit',(evt)=>
        id = @delete_blank(answer_id)
        update_content = @comment_get_input_value()
        url = "answers/#{id}"
        @answer_jQuery_ajax(url, 'PATCH', update_content, @reback_answer_content(dom,update_content))

    @$elm.on 'click','.question-comment-count',(evt)=>
      @question_comment_view()

    @$elm.on 'click','.question-comment-content-area',(evt)=>
      classname = "question-comment-buttons"
      @add_buttons(classname)

      @$elm.on 'click','.question-comment-buttons .cancel',(evt)=>
        @delete_input_and_buttons()

      @$elm.on 'click','.question-comment-buttons .submit',(evt)=>
        content = @question_get_input_value()
        current_user = @question_get_current_user()
        url = "question_comments"
        @question_comment_jQuery_ajax(url,'POST',content,@view_new_question_comment(content,current_user))

    @$elm.on 'click','.answer-comment-count',(evt)=>
      @answer_comment_view()

    @$elm.on 'click','.answer-comment-content-area',(evt)=>
      answer_id = @get_answer_id()
      classname = "answer-comment-buttons"
      @add_buttons(classname)

      @$elm.on 'click','.answer-comment-buttons .cancel',(evt)=>
        @delete_input_and_buttons()

      @$elm.on 'click','.answer-comment-buttons .submit',(evt)=>
        content = @answer_get_input_value()
        current_user = @answer_get_current_user()
        url = "answers/#{answer_id}/answer_comments"
        @answer_comment_jQuery_ajax(url,'POST',content,@view_new_answer_comment(content,current_user))

    @$elm.on 'click','.question-comment-response',(evt)=>
      id = @get_question_comment_id()
      classname = "question-comment-response-buttons"
      @add_input_and_buttons(classname)

      @$elm.on 'click', '.question-comment-response-buttons .cancel', (evt)=>
        @delete_input_and_buttons()

      @$elm.on 'click','.question-comment-response-buttons .submit',(evt)=>
        content = @comment_get_input_value()
        current_user = @question_get_current_user()
        url = "question_comments"
        @comment_question_comment_jQuery_ajax(url,'POST',content,id,@view_new_question_comment(content,current_user))

    @$elm.on 'click','.delete-question-comment',(evt)=>
      id = @get_question_comment_id()
      url = "question_comments/#{id}"
      @delete_jQuery_ajax(url)
  
    @$elm.on 'click','.answer-comment-response',(evt)=>
      id = @get_answer_comment_id()
      answer_id = @get_answer_id()
      classname = "answer-comment-response-buttons"
      @add_input_and_buttons(classname)

      @$elm.on 'click', '.answer-comment-response-buttons .cancel', (evt)=>
        @delete_input_and_buttons()

      @$elm.on 'click','.answer-comment-response-buttons .submit',(evt)=>
        content = @comment_get_input_value()
        current_user = @answer_get_current_user()
        url = "answers/#{answer_id}/answer_comments"
        @comment_answer_comment_jQuery_ajax(url,'POST',content,id,@view_new_answer_comment(content,current_user))
    
    @$elm.on 'click','.delete-answer-comment',(evt)=>
      id = @get_answer_comment_id()
      answer_id = @get_answer_id()
      url = "answers/#{answer_id}/answer_comments/#{id}"
      @delete_jQuery_ajax(url)

class QuestionPage extends Function
  constructor: (@$elm)->
    @bind_events()

  bind_events: ->
    @$elm.on 'click','.question-comment-count',(evt)=>
      @question_comment_view()

    @$elm.on 'click','.question-comment-content-area',(evt)=>
      classname = "question-comment-buttons"
      @add_buttons(classname)

      @$elm.on 'click','.question-comment-buttons .cancel',(evt)=>
        @delete_input_and_buttons()

      @$elm.on 'click','.question-comment-buttons .submit',(evt)=>
        current_user = @question_get_current_user()
        content = @question_get_input_value()
        question_id = @get_question_id()
        url = "questions/#{question_id}/question_comments"
        @question_comment_jQuery_ajax(url,'POST',content,@view_new_question_comment(content,current_user))

    @$elm.on 'click','.question-comment-response',(evt)=>
      id = @get_question_comment_id()
      classname = "question-comment-response-buttons"
      @add_input_and_buttons(classname)

      @$elm.on 'click', '.question-comment-response-buttons .cancel', (evt)=>
        @delete_input_and_buttons()

      @$elm.on 'click','.question-comment-response-buttons .submit',(evt)=>
        content = @comment_get_input_value()
        question_id = @get_question_id()
        current_user = @question_get_current_user()
        url = "questions/#{question_id}/question_comments"
        @comment_question_comment_jQuery_ajax(url,'POST',content,id,@view_new_question_comment(content,current_user))

    @$elm.on 'click','.delete-question-comment',(evt)=>
      id = @get_question_comment_id()
      question_id = @get_question_id()
      url = "questions/#{question_id}/question_comments/#{id}"
      @delete_jQuery_ajax(url)




