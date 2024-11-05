using HelloWorldAPI.Core.Entities;
using HelloWorldAPI.Core.Services;
using Microsoft.AspNetCore.Mvc;

namespace HelloWorldAPI.Controllers
{
    [ApiController]
    [Route("[controller]")]
    public class UserController : ControllerBase
    {
        private readonly ILogger<UserController> _logger;

        private readonly UserService _userService;

        public UserController(ILogger<UserController> logger, UserService userService)
        {
            _logger = logger;
            _userService = userService;
        }

        [HttpGet("GetAll")]
        public List<User> Get()
        {
            return _userService.GetAll();
        }
    }
}
