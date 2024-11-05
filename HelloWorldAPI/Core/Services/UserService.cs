using HelloWorldAPI.Core.Entities;
using HelloWorldAPI.Core.Repositories.User;

namespace HelloWorldAPI.Core.Services
{
    public class UserService
    {
        public readonly IUserRepository _userRepository;

        public UserService(IUserRepository userRepository)
        {
            _userRepository = userRepository;
        }

        public List<User> GetAll()
        {
            return _userRepository.GetAll<User>().ToList();
        }
    }
}
