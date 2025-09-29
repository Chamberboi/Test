using Microsoft.AspNetCore.Mvc;
using Test.Models; // namespace chứa User và DbContext
using System.Linq;

namespace Test.Controllers
{
    [ApiController]
    [Route("api/[controller]")]
    public class LoginController : ControllerBase
    {
        private readonly TestLoginContext _context;

        public LoginController(TestLoginContext context)
        {
            _context = context;
        }

        // Model request
        public class LoginRequest
        {
            public string Username { get; set; }
            public string Password { get; set; }
        }

        // ✅ Endpoint test nhanh
        [HttpGet("ping")]
        public IActionResult Ping()
        {
            return Ok("Login API is alive!");
        }

        // ✅ Endpoint login thật
        [HttpPost]
        public IActionResult Login([FromBody] LoginRequest request)
        {
            if (request == null || string.IsNullOrEmpty(request.Username) || string.IsNullOrEmpty(request.Password))
                return BadRequest(new { message = "Thiếu username hoặc password" });

            // Tìm user theo Username
            var user = _context.Users.FirstOrDefault(u => u.Username == request.Username);

            if (user == null)
                return Unauthorized(new { message = "Sai tên đăng nhập hoặc mật khẩu" });

            if (user.PasswordHash != request.Password) // ⚠️ thực tế nên hash password
                return Unauthorized(new { message = "Sai tên đăng nhập hoặc mật khẩu" });

            return Ok(new
            {
                message = "Đăng nhập thành công",
                user = new
                {
                    user.Id,
                    user.Username,
                    user.Email,
                    user.CreatedAt
                }
            });
        }
    }
}
