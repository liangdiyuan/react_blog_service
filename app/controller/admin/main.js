"use strice";
const Controller = require("egg").Controller;

class MainController extends Controller {
  async Login() {
    const { ctx } = this;
    const { request } = ctx;
    const { userName, password } = request.body;
    console.log(userName, password)
    const sql = `SELECT user_name FROM admin_user WHERE user_name = ? AND password = ?`;
    const res = await this.app.mysql.query(sql, [userName, password]);
    if (res.length > 0) {
      const openId = new Date().getTime();
      ctx.session.openId = openId;
      ctx.body = { data: openId, msg: "登录成功", code: 0 };
    } else {
      ctx.body = { data: "", msg: "登录失败", code: -1 };
    }
  }
}

module.exports = MainController;
