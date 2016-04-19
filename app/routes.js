module.exports = function (express, client) {
	/*
	* Backend router for /api/ routing
	* @param express Express
	* @param client PG.CLIENT
	*/
	var apiRouter = require('./routes/api')(express, client);
	/*
	* Frontend router for / routing
	* @param express Express
	* @param client PG.CLIENT
	*/
	var appRouter = require('./routes/view')(express, client);
};
