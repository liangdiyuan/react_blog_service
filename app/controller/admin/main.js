"use strice";
const Controller = require("egg").Controller;

class MainController extends Controller {
  async Login() {
    const { ctx } = this;
    const { request } = ctx;
    const { userName, password } = request.body;
    const sql = `SELECT user_name FROM admin_user WHERE user_name = ? AND password = ?`;
    const result = await this.app.mysql.query(sql, [userName, password]);
    if (result.length > 0) {
      const openId = new Date().getTime();
      ctx.session.openId = openId;
      ctx.body = { data: openId, msg: "登录成功", code: 0 };
    } else {
      ctx.body = { data: "", msg: "登录失败", code: -1 };
    }
  }

  async getArticleTypeList() {
    const { ctx } = this;
    try {
      const sql = `
      SELECT id, type_name as typeName, 
      order_num as orderNum, icon_name as iconName 
      FROM article_type`;

      const result = await this.app.mysql.query(sql);
      ctx.body = {
        msg: "请求成功",
        data: result,
        code: 0,
      };
    } catch (error) {
      ctx.body = {
        msg: "系统出错",
        data: error,
        code: -1,
      };
    }
  }

  async createArticle() {
    const { ctx } = this;
    const { request } = ctx;
    const { typeId, title, articleContent, introduce } = request.body;
    const createTime = new Date().getTime() / 1000;

    const sql = `
    INSERT INTO article 
    ( type_id, title, article_content, introduce, create_time ) 
    VALUES 
    ( ?, ?, ?, ?, ? )`;

    const result = await this.app.mysql.query(sql, [
      typeId,
      title,
      articleContent,
      introduce,
      createTime,
    ]);

    const insertSuccess = result.affectedRows === 1;
    const insertId = result.insertId;
    ctx.body = {
      msg: "请求成功",
      data: { insertSuccess, insertId },
      code: 0,
    };
  }

  async getArticleById() {
    try {
      const { ctx } = this;
      const { id } = ctx.params;
      const sql = `
        SELECT article.id as id, 
        article.title as title, 
        article.introduce as introduce, 
        article.article_content as articleContent, 
        article.view_count as viewCount, 
        FROM_UNIXTIME(article.create_time,'%Y-%m-%d %H:%i:%s') as createTime, 
        article_type.type_name as typeName 
        FROM article LEFT JOIN article_type ON article.type_id = article_type.id 
        WHERE article_type.id = ?
        `;

      const result = await this.app.mysql.query(sql, [id]);
      ctx.body = {
        msg: "请求成功",
        data: result,
        code: 0,
      };
    } catch (error) {
      ctx.body = {
        msg: "系统出错",
        data: error,
        code: -1,
      };
    }
  }

  async getArticleList() {
    const sql = `
    SELECT article.id as id, 
    article.title as title, 
    article.introduce as introduce, 
    article.article_content as articleContent, 
    article.view_count as viewCount, 
    FROM_UNIXTIME(article.create_time,'%Y-%m-%d %H:%i:%s') as createTime, 
    article_type.type_name as typeName 
    FROM article LEFT JOIN article_type ON article.type_id = article_type.id
    `;

    const results = await this.app.mysql.query(sql);
    this.ctx.body = { data: results, msg: "请求成功", code: 0 };
  }

  async deleteArticleById() {
    const { ctx } = this;
    const { id } = ctx.request.body;

    if (!id && id !== 0) {
      return (ctx.body = {
        code: -1,
        data: {},
        msg: "缺少参数",
      });
    }

    const result = await this.app.mysql.delete("article", { id: id });

    const insertSuccess = result.affectedRows === 1;
    const insertId = result.insertId;
    ctx.body = {
      code: 0,
      data: { insertSuccess, insertId },
      msg: "删除成功",
    };
  }
}

module.exports = MainController;
