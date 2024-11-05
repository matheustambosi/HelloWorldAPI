using Dapper;
using Npgsql;

namespace HelloWorldAPI.Core.Repositories
{
    public class RepositoryBase : IRepositoryBase
    {
        private readonly string _connString;

        public RepositoryBase(IConfiguration configuration)
        {
            _connString = configuration.GetConnectionString("DefaultConnection");
        }

        public IEnumerable<T> GetAll<T>() where T : class
        {
            using var db = new NpgsqlConnection(_connString);

            return db.Query<T>($"SELECT * FROM users");
        }
    }
}
