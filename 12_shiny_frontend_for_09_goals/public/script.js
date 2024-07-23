function toggle_password(password_input_id, toggle_btn_id) {
  $(document).ready(function () {
    $("#" + toggle_btn_id).on("click", function () {
      let password_input = $("#" + password_input_id);
      let password_field_type = password_input.attr("type");

      password_input.attr(
        "type",
        password_field_type === "password" ? "text" : "password"
      );

      $(this).find("i").toggleClass("fa-eye fa-eye-slash");
    });
  });
}
