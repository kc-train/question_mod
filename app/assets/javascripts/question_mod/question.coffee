jQuery(document).on 'page:change', ->
  if jQuery('.page-answers-index').length
    new AnswerPage jQuery('.page-answers-index')
  if jQuery('.page-questions-index').length
    new QuestionPage jQuery('.page-questions-index')
class AnswerPage
  constructor: (@$elm)->
    @bind_events()

  delete_blank: (str)->
    str.replace(/(^\s+)|(\s+$)/g,"")

  reback_answer_content: (dom,update_content)->
    jQuery('.textarea').closest('td').after(dom);
    jQuery('.textarea').closest('td').closest('.col-md-10').find('.content').text(update_content)
    jQuery('.textarea').closest('td').remove();

  content_text_area: (answer_content)->
    content_text_area = "<td>"+
        "<input type='text' name='textfield' class='textarea' value=" + answer_content + ">" +
        "<button class='submit'> 提交 </span>"+
        "<button class='cancel'>取消</span>"+
        "</td>"

  bind_events: ->
    @$elm.on 'click','.answer-update',(evt)=>
      answer_content = jQuery(event.target).closest('.answer-content').find('.content').text()
      content_text_area = @content_text_area(answer_content)
      dom = jQuery(event.target).closest('.answer-content').clone()
      jQuery(event.target).closest('.answer-content').before(content_text_area)
      answer_id = jQuery(event.target).closest('.answer-content').find('.answer-id').text()
      jQuery(event.target).closest('.answer-content').remove()

      @$elm.on 'click','.cancel',(evt)=>
        jQuery(event.target).closest('td').after(dom)
        jQuery(event.target).closest('td').remove()

      @$elm.on 'click','.submit',(evt)=>
        id = @delete_blank(answer_id)
        update_content = jQuery(event.target).closest('td').find('.textarea').val()
        url = 'answers/' + id
        jQuery.ajax
          url: url,
          type: 'PATCH',
          data: {
            'answer[content]': update_content,
          },
          success: @reback_answer_content(dom,update_content)

class QuestionPage
  constructor: (@$elm)->
    @bind_events()

  new_question_form: ->
    question_text_area = "<div>" +
        "<div>" + 
        "<div>" + "title" + "</div>" +
        "<input class='string required title' required='required' aria-required='true' type='text' name='question[title]' id='question_title'>" +
        "</div>" + 
        "<div>" + 
        "<div>" + "content" + "</div>" +
        "<textarea class='text required content' required='required' aria-required='true' name='question[content]' id='question_content'></textarea>" +
        "</div>" +  
        "<button class='submit'> 提交 </span>"+
        "<button class='cancel'>取消</span>"+
        "</div>"

  reback_question_button: ($add_button)->
    jQuery(event.target).parent().before($add_button)
    jQuery(event.target).parent().remove()

  bind_events: ->
    @$elm.on 'click','.add-question',(evt)=>
      $add_button = jQuery(event.target).clone()
      jQuery(event.target).remove()
      form = @new_question_form()
      @$elm.find('.questions').before(form)
    
      @$elm.on 'click','.cancel',(evt)=>
        @reback_question_button($add_button)

      @$elm.on 'click','.submit',(evt)=>
        title = jQuery(event.target).closest('div').find('.title').val()
        content = jQuery(event.target).closest('div').find('.content').val()
        jQuery.ajax
          url: 'questions',
          type: 'POST',
          data: {
            'question[title]': title,
            'question[content]': content,
          },
          success: @reback_question_button($add_button)




