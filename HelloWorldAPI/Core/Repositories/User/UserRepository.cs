namespace HelloWorldAPI.Core.Repositories.User
{
    public class UserRepository : RepositoryBase, IUserRepository
    {
        public UserRepository(IConfiguration configuration) : base(configuration)
        {
        }
    }
}
