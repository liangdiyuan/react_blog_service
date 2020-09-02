"use strict";

/**
 * @param {Egg.Application} app - egg application
 */
module.exports = (app) => {
  const { router, controller } = app;
  router.get("/client/list", controller.client.home.index);
  router.get("/article/getList", controller.client.home.getArticleList);
  router.get(
    "/article/getArticleById/:id",
    controller.client.home.getArticleById
  );
  router.get(
    "/article/getArticleListById/:id",
    controller.client.home.getArticleListById
  );
  router.get(
    "/article/getArticleTypeList",
    controller.client.home.getArticleTypeList
  );

};
