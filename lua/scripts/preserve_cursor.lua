-- credits: https://github.com/gbprod/yanky.nvim
local preserve_cursor = {}

preserve_cursor.state = {
    cusor_position = nil,
    win_state = nil,
}

function preserve_cursor.on_yank()
    if nil ~= preserve_cursor.state.cusor_position then
        vim.fn.setpos(".", preserve_cursor.state.cusor_position)
        vim.fn.winrestview(preserve_cursor.state.win_state)

        preserve_cursor.state = {
            cusor_position = nil,
            win_state = nil,
        }
    end
end

function preserve_cursor.yank()
    preserve_cursor.state = {
        cusor_position = vim.fn.getpos("."),
        win_state = vim.fn.winsaveview(),
    }

    vim.api.nvim_buf_attach(0, false, {
        on_lines = function()
            preserve_cursor.state = {
                cusor_position = nil,
                win_state = nil,
            }

            return true
        end,
    })
end

return preserve_cursor
