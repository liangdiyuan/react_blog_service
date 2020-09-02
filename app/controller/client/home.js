"use strict";

const Controller = require("egg").Controller;

class HomeController extends Controller {
  async index() {
    const { ctx } = this;
    ctx.body = "api";
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
    this.ctx.body = { data: results };
  }

  async getArticleListById() {
    const { id } = this.ctx.params;
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

    const results = await this.app.mysql.query(sql, [id]);
    this.ctx.body = { data: results };
  }

  async getArticleTypeList() {
    const results = await this.app.mysql.select("article_type", {});
    this.ctx.body = results;
  }

  async getArticleById() {
    const { id } = this.ctx.params;

    const sql = `
    SELECT article.id as id, 
    article.title as title, 
    article.introduce as introduce, 
    article.article_content as articleContent, 
    article.view_count as viewCount, 
    FROM_UNIXTIME(article.create_time,'%Y-%m-%d %H:%i:%s') as createTime, 
    article_type.type_name as typeName, 
    article_type.id as typeId 
    FROM article LEFT JOIN article_type ON article.type_id = article_type.id 
    WHERE article.id = ?
    `;

    const results = await this.app.mysql.query(sql, [id]);
    this.ctx.body = { data: results[0] };
  }
}

module.exports = HomeController;
