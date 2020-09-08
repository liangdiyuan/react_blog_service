"use strice";

module.exports = (app) => {
  const { router, controller } = app;
  const adminauth = app.middleware.adminauth();
  router.post("/admin/login", controller.admin.main.Login);
  router.post(
    "/admin/getArticleTypeList",
    adminauth,
    controller.admin.main.getArticleTypeList
  );
  router.post(
    "/admin/createArticle",
    adminauth,
    controller.admin.main.createArticle
  );
  router.post(
    "/admin/getArticleById",
    adminauth,
    controller.admin.main.getArticleById
  );
  router.post(
    "/admin/getArticleList",
    adminauth,
    controller.admin.main.getArticleList
  );
};
