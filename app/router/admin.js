"use strice";

module.exports = (app) => {
  const { router, controller } = app;
  const adminauth = app.middleware.adminauth();
  router.post("/admin/login", controller.admin.main.Login);
  router.get(
    "/admin/getArticleTypeList",
    adminauth,
    controller.admin.main.getArticleTypeList
  );
  router.post(
    "/admin/createArticle",
    adminauth,
    controller.admin.main.createArticle
  );
  router.get(
    "/admin/getArticleById",
    adminauth,
    controller.admin.main.getArticleById
  );
  router.get(
    "/admin/getArticleList",
    adminauth,
    controller.admin.main.getArticleList
  );
  router.post(
    "/admin/deleteArticleById",
    adminauth,
    controller.admin.main.deleteArticleById
  );
  router.post(
    "/admin/updateArticle",
    adminauth,
    controller.admin.main.updateArticle
  );
};
