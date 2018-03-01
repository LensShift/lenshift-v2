<template>
  <div class="cell small-12 medium-8 large-6 medium-offset-2 large-offset-3">
    <h2>Edit Lens shifter</h2> 
    <form novalidate="novalidate" id="edit_lens_shifter" action="/lens_shifters" accept-charset="UTF-8" method="post" class="simple_form edit_lens_shifter">

      <input name="utf8" type="hidden" value="✓">
      <input type="hidden" name="_method" value="put">
      <input type="hidden" name="authenticity_token" value="JMzRT73cO3k1gJLIl8X4JABsIxAYTIvkiwml14VKTZXs2ciOQ6Rkut31WqSgS9ND0p2Wusor4AdWz9UxGlt3wQ=="> 
    <div class="form-inputs">

      <div class="input email required lens_shifter_email">
        <label for="lens_shifter_email" class="email required">
          <abbr title="required">*</abbr> Email
        </label>
        <input autofocus="autofocus" required="required" aria-required="true" type="email" value="weihsi.hu@gmail.com" name="lens_shifter[email]" id="lens_shifter_email" class="string email required">
      </div> 
      
      <div class="input password optional lens_shifter_password field_with_hint">
        <label for="lens_shifter_password" class="password optional">Password</label>
        <input type="password" name="lens_shifter[password]" id="lens_shifter_password" class="password optional">
      </div> 
      
      <div class="input password optional lens_shifter_password_confirmation">
        <label for="lens_shifter_password_confirmation" class="password optional">Password confirmation</label>
        <input type="password" name="lens_shifter[password_confirmation]" id="lens_shifter_password_confirmation" class="password optional">
      </div> 
      
      <div class="input password required lens_shifter_current_password field_with_hint">
        <label for="lens_shifter_current_password" class="password required">
          <abbr title="required">*</abbr> Current password</label>
        <input required="required" aria-required="true" type="password" name="lens_shifter[current_password]" id="lens_shifter_current_password" class="password required">
      </div>
      
    </div> 
    
    <div class="form-actions">

      <input type="submit" name="commit" value="Update" data-disable-with="Update" class="button">
    </div>
    
    </form> 
    
    <h3>Cancel my account
      </h3> 
      <p>Unhappy? 

      <a data-confirm="Are you sure?" rel="nofollow" data-method="delete" href="/lens_shifters">Cancel my account
      </a>
      </p> 
      <a href="http://localhost:3000/dashboard">Back
      </a>
  </div>

</template>

<script>

export default {
  data: function () {
    return {
      message: "Hello Vue! Everyone two"
    }
  }
}
</script>