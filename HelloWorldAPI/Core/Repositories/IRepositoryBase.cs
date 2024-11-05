namespace HelloWorldAPI.Core.Repositories
{
    public interface IRepositoryBase
    {
        IEnumerable<T> GetAll<T>() where T : class;
    }
}
