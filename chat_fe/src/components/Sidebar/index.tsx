export const Sidebar = () => {
  return (
    <div className='tw-'>
      <h3>John Smith</h3>
      <p>Last active: {Math.floor((Math.random() * 10) + 1)} minutes ago.</p>
    </div>
  )
}
