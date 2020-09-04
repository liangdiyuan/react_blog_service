"use strice";

module.exports = (app) => {
  const { router, controller } = app;
  router.post("/admin/login", controller.admin.main.Login);
};
